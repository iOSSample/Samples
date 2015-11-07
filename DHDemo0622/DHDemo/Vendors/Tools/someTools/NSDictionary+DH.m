//
//  NSDictionary+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/7/15.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NSDictionary+DH.h"

@implementation NSDictionary (DH)
//
// 返回 JSON形式的字符串
//
- (NSString *)JSONRepresentation{
    
    NSData* data = [NSJSONSerialization dataWithJSONObject: self options: 0 error: nil];
    NSString* result = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    
    return result;
}
@end
