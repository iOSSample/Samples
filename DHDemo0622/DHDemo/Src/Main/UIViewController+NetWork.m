//
//  UIViewController+NetWork.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/24.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UIViewController+NetWork.h"

@implementation UIViewController (NetWork)

-(void)sendPostRequest:(NSString *)posturl parameter:(NSDictionary*)parameters postTag:(int) tag{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval=5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSMutableDictionary * mudic=[[NSMutableDictionary alloc] initWithDictionary:parameters];
    //加入新参数
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString * version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    [mudic setObject:version forKey:@"version"];
    NSLog(@"接口 %@ 参数 %@",posturl,mudic);
    
    //2.2.0
    NSString * temp= [posturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:temp parameters:mudic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        mudic=nil;
        
        NSLog(@"%d 返回: %@",tag, responseObject);
        [self callBackRequest:posturl  Tag:tag info:responseObject error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        mudic=nil;
        
        NSLog(@"%d Error 返回: %@",tag, error);
        [self callBackRequest:posturl  Tag:tag info:nil error:error];
    }];
}
-(void)sendGetRequest:(NSString *)posturl parameter:(NSDictionary*)parameters postTag:(int) tag{
    __weak UIViewController *weakSelf = self;
    [[NetAPIClient sharedClient] GET:posturl
                          parameters:parameters
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf callBackRequest:posturl  Tag:tag info:responseObject error:nil];
    }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf callBackRequest:posturl  Tag:tag info:nil error:error];
    }];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer.timeoutInterval=5;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager.requestSerializer setValue: @"application/json"
//                  forHTTPHeaderField: @"Accept"];
//    [manager.requestSerializer setValue:BaiDuApiKey forHTTPHeaderField:@"apikey"];
////    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSLog(@"接口 %@ \n参数 %@",posturl,parameters);
//    
//    __weak UIViewController *weakSelf = self;
//    NSString * temp= [posturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [manager GET:temp parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        mudic=nil;
//        
//        NSLog(@"%d 返回: %@",tag, responseObject);
//        
//        NSString *html = operation.responseString;
//        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
//        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"获取到的数据为：%@",dict);
//        
//        [weakSelf callBackRequest:posturl  Tag:tag info:responseObject error:nil];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%d Error 返回: %@",tag, error);
//        [weakSelf callBackRequest:posturl  Tag:tag info:nil error:error];
//    }];
}
-(void)callBackRequest:(NSString *)posturl Tag:(int) tag info:(NSDictionary*)info error:(NSError*)error{
}

@end
