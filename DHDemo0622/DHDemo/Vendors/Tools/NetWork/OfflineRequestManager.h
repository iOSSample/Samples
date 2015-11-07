//
//  OfflineRequestManager.h
//  DiabetesManagement
//  离线待上传数据管理类
//  Created by 杜豪 on 15/7/15.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef void(^ParseDBData)(id responseObject);

// 每个任务的item
@interface OfflineRequestItem : NSObject
/*rowCount	cId,url,parameter,extraInfo,timeStamp,requestCount*/
@property (nonatomic,strong)NSString *cId;
@property (nonatomic,strong)NSString *url;
@property (nonatomic, strong) NSDictionary *parameter;
@property (nonatomic, strong) NSDictionary *extraInfo;
@property (nonatomic, strong) NSNumber *rowCount;                   // 用于在数据库中唯一标记一个任务的id列表
@property (nonatomic) NSInteger requestCount;                 // 请求失败的次数
@property(nonatomic)NSInteger timeStamp;

@end



@interface OfflineRequestManager : NSObject


+ (instancetype)sharedInstance;

+ (void)addRequestWithOfflineRequestItem:(OfflineRequestItem *)item;

+ (void)requestRealTimeWithItem:(OfflineRequestItem *)item
                        success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 返回当前的网络环境
+ (NetworkStatus)netWorkStatus;

// 检查看看是否有需要发送的任务
+ (void)setNeedRequestServer;

@property (nonatomic) NSMutableArray *offlineTaskList;

@end



@interface OfflineRequestDBHelper : NSObject

// 数据库中增加一个字段
// path ：请求的相对地址
// para 和 extraInfo都是dict
+ (void)addRequestWithOfflineRequestItem:(OfflineRequestItem *)item;

//
// 获取离线的列表
//
+ (void)getRqeustListSuccess:(ParseDBData)success;

//
// 删除某一个rowcount的任务（已经发送成功的）
//
+ (void)deleteRequestItemWithRowCount:(NSNumber*)rowCount;
@end
