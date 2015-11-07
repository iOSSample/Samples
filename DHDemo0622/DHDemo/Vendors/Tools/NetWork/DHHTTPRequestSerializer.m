//
//  DHHTTPRequestSerializer.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/22.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "DHHTTPRequestSerializer.h"

@implementation DHHTTPRequestSerializer
- (id)init {
    self = [super init];
    if (self) {
        
        self.timeoutInterval = 10;
    }
    return self;
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    
    // 增加自己的一些连接上的参数
    NSString *newURLString = [URLString urlPathWithCommonStat];
#ifdef IN_DHDEMO
    NSURL *newURL = [NSURL URLWithString: newURLString];
    NSDictionary *getQuery = [newURL.query queryDictionaryUsingEncoding: NSUTF8StringEncoding];
    NSMutableDictionary *mutaDict = [NSMutableDictionary dictionaryWithDictionary: getQuery];
    if (!!parameters) {
        [mutaDict addEntriesFromDictionary: parameters];
    }
    
    NSString *queryString = [self stringByAddingQueryDictionary: mutaDict];
    NSString *signString = [queryString stringByAppendingString: kSignConstString];
    NSString *sign = [signString md5Hash];
    DHLog(@"origin : %@   sign : %@", signString, sign);
    
    NSMutableDictionary *queryWithSign = [NSMutableDictionary dictionaryWithDictionary: parameters];
    queryWithSign[@"paramSign"] = [DHRosource sureNotNull:sign];
    return [super requestWithMethod: method
                          URLString: newURLString
                         parameters: [queryWithSign copy]
                              error: error];
#else
    return [super requestWithMethod: method
                          URLString: newURLString
                         parameters: parameters
                              error: error];
#endif
    
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [[query allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare: obj2];
    }]) {
        //        NSString* value = [GET_STRING([query objectForKey:key]) stringByAddingPercentEscapesForURLParameter];
        NSString* value = GET_STRING([query objectForKey:key]);
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    
    return params;
}

@end
