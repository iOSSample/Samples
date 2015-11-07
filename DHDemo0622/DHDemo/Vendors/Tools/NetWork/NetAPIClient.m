//
//  NetAPIClient.m
//  DHDemo
//
//  Created by 51Talk Mac Air on 15/3/20.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NetAPIClient.h"
#import "DHHTTPRequestSerializer.h"

@implementation NetAPIClient

+ (instancetype)sharedClient {
    static NetAPIClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString: @""API_HOST]];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
// Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
//        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
        // 为了https请求正常
        self.securityPolicy.allowInvalidCertificates = YES;
        
        self.requestSerializer = [DHHTTPRequestSerializer serializer];
        [self.requestSerializer setValue: @"application/json"
                      forHTTPHeaderField: @"Accept"];
        
//        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        //百度测试api代码
        [self.requestSerializer setValue:BaiDuApiKey forHTTPHeaderField:@"apikey"];

    }
    
    
    return self;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    // 做一些客户端里面对于网络请求的统一处理
    void(^successWithProcess)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id JSON){
        
        id dict=[NSJSONSerialization  JSONObjectWithData:JSON options:0 error:nil];
//        NSLog(@"获取到的数据为：%@",dict);

#ifdef IN_DHDEMO
        if ([dict isKindOfClass: [NSDictionary class]]) {
            if (!!dict[@"errNum"]) {
                if ([dict[@"errNum"] integerValue] != 0){
                    NSDictionary* userInfo = @{@"retMsg" : [self descriptionForResponceObject:dict]};
                    NSError *error = [[NSError alloc] initWithDomain: NSURLErrorDomain
                                                                code: [dict[@"errNum"] integerValue]
                                                            userInfo: userInfo];
                    failure(operation, error);
                }else{//errNum = 0
                    success(operation, dict);
                }
            }else{
                success(operation, dict);
            }
        }else{//非 json类型
            success(operation, JSON);
        }
#else
        success(operation, JSON);
#endif
        
    };
    
    [operation setCompletionBlockWithSuccess:successWithProcess failure:failure];
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;
    
    return operation;
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
path:(NSString *)path
parameters:(NSDictionary *)parameters {
    
    // PATH:
    
    
    //    NSMutableURLRequest* request = [super requestWithMethod: method
    //                                                       path: path
    //                                                 parameters: parameters];
    
    //    request.timeoutInterval = 10;
    //
    //    return request;
    // 加入域名
    NSURL *resultUrl = [NSURL URLWithString:path relativeToURL:self.baseURL];
    path = [resultUrl absoluteString];
    NSError *error;
    return [self.requestSerializer requestWithMethod: method
                                           URLString: path
                                          parameters: parameters
                                               error: &error];
    
}

- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
    [self.operationQueue addOperation:operation];
}

- (AFHTTPRequestOperation*) downLoadFilePath: (NSString*)path
                                   localPath: (NSString*)localPath
                                     success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                    progress: (void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)) progressBlock {
    NSMutableURLRequest *originRequest = [self.requestSerializer requestWithMethod: @"GET"
                                                                         URLString: path
                                                                        parameters: nil
                                                                             error: nil];
    //    originRequest.
    originRequest.timeoutInterval = 60;

    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest: originRequest
                                                                      success: success
                                                                      failure: failure];
    [operation setDownloadProgressBlock: progressBlock];
    operation.outputStream = [[NSOutputStream alloc] initToFileAtPath: localPath
                                                               append: NO];
    [self.operationQueue addOperation: operation];
    
    return operation;
}
//解析返回json中的状态描述
- (NSString *)descriptionForResponceObject:(id)responceObject{
    if ([responceObject isKindOfClass: [NSDictionary class]]) {
        return responceObject[@"retMsg"];
    } else {
        return @"未知错误";
    }
}

@end

