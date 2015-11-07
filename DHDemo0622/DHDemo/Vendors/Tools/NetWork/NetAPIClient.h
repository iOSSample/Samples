//
//  NetAPIClient.h
//  DHDemo
//
//  Created by 51Talk Mac Air on 15/3/20.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

//typedef enum {
//    kSNHttpRequestContentTypeNone,
//    kSNHttpRequestContentTypeJSON,
//    kSNHttpRequestContentTypeXML,
//    kSNHttpRequestContentTypeImage,
//} SNHttpRequestContentType;

@interface NetAPIClient : AFHTTPRequestOperationManager


+ (instancetype)sharedClient;

//- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
//                                         requestContentType:(SNHttpRequestContentType) contentType
//                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//
//// 指定ContentType的post request
//- (void)    postPath:(NSString *)path
//          parameters:(NSDictionary *)parameters
//  requestContentType: (SNHttpRequestContentType) contentType
//             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
////
//// 通过Https来访问服务器(建议: path使用完整的URL)
////
//- (void)    httpsPost: (NSString *)path
//           parameters: (NSDictionary *)parameters
//   requestContentType: (SNHttpRequestContentType) contentType
//              success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//              failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//
//// 指定ContentType的Get request
//- (void)    httpsGet: (NSString *)path
//          parameters: (NSDictionary *)parameters
//  requestContentType: (SNHttpRequestContentType) contentType
//             success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//             failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//// 指定ContentType的Get request
//- (void)    getPath: (NSString *)path
//         parameters: (NSDictionary *)parameters
// requestContentType: (SNHttpRequestContentType) contentType
//            success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//            failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (void)    deletePath:(NSString*) path
//            parameters:(NSDictionary*) parameters
//    requestContentType:(SNHttpRequestContentType) contentType
//               success:(void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//               failure:(void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure;
//
//
//// 创建带有 timeout的URLRequest
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters;


//// 创建带有 timeout的URLRequest
//- (NSMutableURLRequest *)multipartFormRequestWithMethod: (NSString *)method
//                                                   path: (NSString *)path
//                                             parameters: (NSDictionary *)parameters
//                              constructingBodyWithBlock: (void (^)(id <AFMultipartFormData> formData))block
//                                             andTimeout: (int) timeoutSeconds;
//
//// 下载皮片
//- (void) ImagePath: (NSString*) path
//           success: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
//           failure: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure ;
//
//
//

//
// 下载一个资源文件
//
- (AFHTTPRequestOperation*) downLoadFilePath: (NSString*)path
                                   localPath: (NSString*)localPath
                                     success: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                    progress: (void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)) progressBlock;
@end
