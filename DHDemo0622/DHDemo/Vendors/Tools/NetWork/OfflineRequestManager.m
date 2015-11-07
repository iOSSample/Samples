//
//  OfflineRequestManager.m
//  DiabetesManagement
//
//  Created by 杜豪 on 15/7/15.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import "OfflineRequestManager.h"
#import "FMDB.h"

static NSString *kOfflineRequestDBName = @"offline_request.db";
static NSInteger kRequestTimeOutDay = 7;                        // 请求过期的最大天数
static NSInteger kRequestTimeOutCount = 20;                     // 请求过期的最多的请求次数，天数和次数同时满足才会删除

//------------------------------------------------------------------------//

@implementation OfflineRequestItem
- (id)init{
    self = [super init];
    if (self) {
        self.cId = @"userid";
        self.url = @"";
        self.parameter = @{};
        self.extraInfo = @{};
    }
    return self;
}
@end

//------------------------------------------------------------------------//


@implementation OfflineRequestManager{
    BOOL _isRequesting;             // 是否正在请求
    Reachability *_reability;       // 监测网络连接
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static OfflineRequestManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[OfflineRequestManager alloc] init];
    });
    return sharedManager;
}
- (id)init {
    self = [super init];
    if (self) {

        _reability = [Reachability reachabilityForInternetConnection];
        [_reability startNotifier];
        
        NetworkStatus remoteHostStatus = [_reability currentReachabilityStatus];
        NSString *netWorkStatus = @"";
        switch (remoteHostStatus) {
            case ReachableViaWiFi: {
                netWorkStatus = @"Wifi";
            }
                break;
            case ReachableViaWWAN: {
                netWorkStatus = @"3G/Gprs";
            }
                break;
            case NotReachable: {
                netWorkStatus = @"无网络";
            }
                break;
            default:
                netWorkStatus = @"未知网络";
                break;
        }
        
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onNetworkStatusChanged:)
                                                     name: kReachabilityChangedNotification
                                                   object: nil];
        
        // 程序进入到前台也进行一个同步的处理
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onNetworkStatusChanged:)
                                                     name: UIApplicationWillEnterForegroundNotification
                                                   object: nil];
        
        // 每次进来都进行同步
        [self setNeedRequestServer];
    }
    return self;
}

+ (void)addRequestWithOfflineRequestItem:(OfflineRequestItem *)item{
    return [[self sharedInstance] addRequestWithOfflineRequestItem:item];
}

- (void)addRequestWithOfflineRequestItem:(OfflineRequestItem *)item{
    
    [OfflineRequestDBHelper addRequestWithOfflineRequestItem:item];
    
    // 每次添加完都进行一次检查看看有没有需要发送的数据
    [self setNeedRequestServer];
}


+ (void)requestRealTimeWithItem:(OfflineRequestItem *)item
                    success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [[self sharedInstance] requestRealTimeWithItem:item
                                                  success: success
                                                  failure: failure];
    
}
// 进行实时的请求
- (void)requestRealTimeWithItem:(OfflineRequestItem *)item
                        success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self runRequestWithItem: item
                     success: success
                     failure: failure];
}

// 如果是realTime的请求，不走正常的队列的逻辑
- (void)runRequestWithItem: (OfflineRequestItem*)item
                   success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    BOOL isRealTime = !!success;        //是否是实时请求
    if (!isRealTime) {
        _isRequesting = YES;
    }
    [[NetAPIClient sharedClient] POST:item.url
                           parameters:item.parameter
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  DHLog(@"上传离线数据=====》success");
                                  if (isRealTime) {
                                      success(operation, responseObject);
                                  } else {
                                      _isRequesting = NO;
                                      // 从数据库中删除
                                      [self.offlineTaskList removeObject: item];
                                      [OfflineRequestDBHelper deleteRequestItemWithRowCount: item.rowCount];
                                      // 继续执行下个任务
                                      [self setNeedRequestServer];
                                  }
                                  
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                                  DHLog(@"上传离线数据=====》failed %@",error);
                                  if (isRealTime) {
                                      failure(operation, error);
                                  } else {
                                      _isRequesting = NO;
                                      item.requestCount ++;
                                      [self setNeedRequestServer];
                                  }
                              }];
}

+ (NetworkStatus)netWorkStatus {
    return [[self sharedInstance] netWorkStatus];
}

- (NetworkStatus)netWorkStatus {
    return [_reability currentReachabilityStatus];
}

// 检查看看有没有需要发送服务器的数据
+ (void)setNeedRequestServer{
    return [[self sharedInstance] setNeedRequestServer];
}
- (void)setNeedRequestServer {
    DHLogMethodName();
    // 如果已经正在请求了，直接返回
    if (_isRequesting) {
        return;
    }
    if ([self netWorkStatus] == NotReachable) {
        //无网络  还往下执行个p
        return;
    }
    if (!self.offlineTaskList || self.offlineTaskList.count <= 0) {
        [OfflineRequestDBHelper getRqeustListSuccess:^(id responseObject) {
            
            if ([responseObject count] == 0) {
                // 没有任务，则什么都不做
            }else {
                // 有数据了开始执行
                NSArray *resultList = responseObject;
                self.offlineTaskList = [resultList mutableCopy];
                [self setNeedRequestServer];
            }
        }];
    }else {
        // 取出失败次数最小的任务，开始执行
        OfflineRequestItem *nextItem = [self getNextRequestItem];
        if(!nextItem) {
            // 没有可以执行的任务，则说明任务都执行完了，或者任务的错误次数都达到3次，此时清空任务列表
            self.offlineTaskList = nil;
        } else {
            [self runRequestWithItem: nextItem success: NULL failure: NULL];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


//
// 网络环境改变之后就同步本地的数据
//
- (void)onNetworkStatusChanged:(NSNotification*)noti {

    NetworkStatus remoteHostStatus = [_reability currentReachabilityStatus];
    if (remoteHostStatus != NotReachable) {
        DHLog(@"网络状态变化 网络可用");
        [self setNeedRequestServer];
    }else{
        DHLog(@"网络状态变化 网络不可用");
    }
}


// 获取到下一个需要执行的任务
// 取到失败次数最小的任务。如果失败次数达到3次，则不再执行
- (OfflineRequestItem*)getNextRequestItem {
    OfflineRequestItem *targetItem = nil;
    
    for (OfflineRequestItem *item in self.offlineTaskList) {
        if (item.requestCount == 0) {
            
            // 失败次数为0，则直接返回这个任务
            targetItem = item;
            break;
        } else if (item.requestCount == 2) {
            // 失败次数已经到达两次什么也不做
        } else if(!targetItem || item.requestCount < targetItem.requestCount) {
            // 找到失败次数最少的那个任务
            targetItem = item;
        }
    }
    return targetItem;
}
@end


//------------------------------------------------------------------------//

@implementation OfflineRequestDBHelper {
    FMDatabaseQueue *_dbQueue;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static OfflineRequestDBHelper *sharedHelper = nil;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[OfflineRequestDBHelper alloc] init];
    });
    return sharedHelper;
}
- (id)init {
    self = [super init];
    if (self) {
        
        // 确保DBQueue存在，因为退出登录后要更换dbQueue的
        [self confirmDBQueue];
        // 监听退出登录
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(userHasLoggedOut)
                                                     name: @"UserHaveLogoutNotification"
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(userHasLoggedOut)
                                                     name: @"UserLoginSuccessNotification"
                                                   object: nil];
    }
    return self;
}

- (void)confirmDBQueue {
    
    @synchronized(self) {
        if (!_dbQueue) {
            
            NSString *dbPath = [NSString stringWithFormat: @"%@%@", [Utility getDataBaseDirectory], kOfflineRequestDBName];
            _dbQueue = [FMDatabaseQueue databaseQueueWithPath: dbPath];
            
            // 建表
            [_dbQueue inDatabase:^(FMDatabase *db) {
                [db open];
                /*rowCount	cId	url	parameter	extraInfo	timeStamp	requestCount*/
                [db executeUpdate: @"CREATE TABLE IF NOT EXISTS request_list (rowCount INTEGER PRIMARY KEY AUTOINCREMENT,cId TEXT , url TEXT , parameter TEXT, extraInfo TEXT, timeStamp INTEGER, requestCount INTEGER)"];
                [db close];
            }];
        }
    }
}

+ (void)addRequestWithOfflineRequestItem:(OfflineRequestItem*)item {
    return [[self sharedInstance] addRequestWithOfflineRequestItem:item];
}

- (void)addRequestWithOfflineRequestItem:(OfflineRequestItem *)item{
    DHLogMethodName();
    
    [self confirmDBQueue];
    NSDictionary *para = !item.parameter ? @{} : item.parameter;
    NSDictionary *extraInfo = !item.extraInfo ? @{} : item.extraInfo;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        /*rowCount,cId,url,parameter,extraInfo,timeStamp,requestCount*/
        NSInteger timeStamp = (NSInteger)[[NSDate date] timeIntervalSince1970];
        BOOL is = [db executeUpdate: @"INSERT INTO request_list VALUES (NULL, ? , ?, ?, ?, ? ,?)", item.cId, item.url,[para JSONRepresentation], [extraInfo JSONRepresentation], @(timeStamp), @(0)];
        DHLog(@"添加一条 离线数据 结果 %d",is);

        [db close];
    }];
}


+ (void)getRqeustListSuccess:(ParseDBData)success {
    return [[self sharedInstance] getRqeustListSuccess:success];
}
//获取未上传列表
- (void)getRqeustListSuccess:(ParseDBData)success {
    DHLogMethodName();
    
    [self confirmDBQueue];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        // 1. 先删除已经过期（大于等于7天，并且请求次数超过20次）的网络请求任务
        NSInteger minTimeStamp = [[NSDate date] timeIntervalSince1970] - kRequestTimeOutDay*24*3600;
        [db executeUpdate: @"DELETE FROM request_list WHERE timeStamp < (?) AND requestCount > (?)", @(minTimeStamp), @(kRequestTimeOutCount)];
        
        // 2. 增加累计请求的次数
        [db executeUpdate: @"UPDATE request_list SET requestCount = requestCount + 1"];
        
        // 3. 取出库里面的任务
        FMResultSet *result = [db executeQuery: @"SELECT * FROM request_list ORDER BY rowCount ASC"];
        
        NSMutableArray *resultList = [NSMutableArray array];
        
        while ([result next]) {
            
            
            OfflineRequestItem *item = [[OfflineRequestItem alloc] init];
            item.rowCount = @([result intForColumn: @"rowCount"]);
            item.cId = [result stringForColumn:@"cId"];
            item.url = [result stringForColumn:@"url"];
            item.parameter = [Utility getJSONWithString: [result stringForColumn: @"parameter"]];
            item.extraInfo = [Utility getJSONWithString: [result stringForColumn: @"extraInfo"]];
            item.timeStamp = [result intForColumn:@"timeStamp"];
            item.requestCount = [result intForColumn:@"requestCount"];
            [resultList addObject: item];
        }
        DHLog(@"查询 离线数据条数 %ld",(long)resultList.count);
        [db close];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success([resultList copy]);
        });
    }];
}


+ (void)deleteRequestItemWithRowCount:(NSNumber *)rowCount{
    return [[self sharedInstance] deleteRequestItemWithRowCount:rowCount];
}

- (void)deleteRequestItemWithRowCount:(NSNumber*)rowCount {
    
    [self confirmDBQueue];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        BOOL is = [db executeUpdate: @"DELETE FROM request_list WHERE rowCount = (?)", rowCount];
        DHLog(@"删除成功上传记录 结果 %d",is);
        [db close];
    }];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

//
// 用户退出后数据库也要刷新
//
- (void) userHasLoggedOut {
    
    [_dbQueue close];
    _dbQueue = nil;
}

@end
