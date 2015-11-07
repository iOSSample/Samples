//
//  NSString+SO.h
//  SpeakOut
//
//  Created by sunny on 14-11-27.
//  Copyright (c) 2014年 51tallk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SO)

//
// 返回带有统计数据的URL
//
- (NSString*) urlPathWithCommonStat;

//
// 带有统计信息的字符串
//
+ (NSString *) commonStatString;

@end
