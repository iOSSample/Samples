//
//  DHRosource.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "DHRosource.h"

@implementation DHRosource
+ (NSString *)getDisplayTimeWithDate:(NSDate*)date {
    long time = 0 - [date timeIntervalSinceNow];
    
    if (time < 60) {
        // 刚刚
        return @"刚刚";
    } else if (time/60 < 60) {
        
        // 分钟
        return [NSString stringWithFormat: @"%ld分钟前", time/60];
    } else if (time/(60*60) < 24) {
        
        // 小时
        return [NSString stringWithFormat: @"%ld小时前", time/3600];
    } else if (time/(60*60*24) < 7) {
        
        // 几天前
        return [NSString stringWithFormat: @"%ld天前", time/(3600*24)];
    } else {
        
        // 几月几日
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM-dd HH:mm";
        return [formatter stringFromDate: date];
    }
}
+ (NSString *)sureNotNull:(id)src{
    return src ? src : @"";
}
@end
