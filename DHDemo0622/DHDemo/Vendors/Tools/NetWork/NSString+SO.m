//
//  NSString+SO.m
//  SpeakOut
//
//  Created by sunny on 14-11-27.
//  Copyright (c) 2014年 51tallk. All rights reserved.
//

#import "NSString+SO.h"

@implementation NSString (SO)

//
// 返回带有统计数据的URL
//
- (NSString*) urlPathWithCommonStat {
    
    // 如果是空字符串，则返回空字符串本身
    if (![self isNonEmpty]) {
        return self;
    }
    
    NSString* commonStat = [[self class] commonStatString];
    
    
    // 如果是外部URL, 则直接返回
    // 如何才是外部URL呢?
    // 首先必须是完整的URL, 并且不包含chunyu
//    if ([self hasPrefix: @"http"]) {
//        NSURL* url = [NSURL URLWithString: self];
//        if ([url.host rangeOfString:@"chunyu"].length == 0) {
//            return self;
//        }
//    }
    
    // 已经带有统计信息了
    if ([self rangeOfString:commonStat].length > 0) {
        return self;
    }
    
    // 添加统计信息
    if ([self rangeOfString:@"?"].length > 0) {
        return [self stringByAppendingFormat:@"&%@", commonStat];
    } else {
        return [self stringByAppendingFormat:@"?%@", commonStat];
    }
}


//
// 统计信息
//
+ (NSString *) commonStatString {
    
    NSString *ver = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // platform: 和发布的app的platform的定义一致: iPad, iPhone, android, 如果需要统计真实的platform, 可以考虑添加其他的参数
    return [NSString stringWithFormat: @"phoneType=%@&systemVer=%@&curVersion=%@&vendor=%@&deviceType=%@&deviceId=%@",
            @"iPhone",
            [Utility escapeURL: [[UIDevice currentDevice] systemVersion]],
            ver,
            [AppDelegate appDelegate].vendor,
            [Utility escapeURL: [[UIDevice currentDevice] model]],
            [[DeviceInfo sharedInstance] uniqueDeviceToken] // 用于数据的统计
            ];
}


@end
