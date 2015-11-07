//
//  NSDate+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NSDate+DH.h"

@implementation NSDate (DH)
- (NSInteger) year {
    
    NSDateComponents* components = [self dateComponents];
    return [components year];
}
- (NSString *)yearStr{
    NSString * str = [NSString stringWithFormat:@"%ld",(long)self.year];
    return str;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) month {
    NSDateComponents* components = [self dateComponents];
    return [components month];
}
- (NSString *)monthStr{
    if (self.month < 10) {
        return  [NSString stringWithFormat:@"0%ld",(long)self.month];
    }else{
        return [NSString stringWithFormat:@"%ld",(long)self.month];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) day {
    NSDateComponents* components = [self dateComponents];
    return [components day];
}
- (NSString *)dayStr{
    if (self.day < 10) {
        return  [NSString stringWithFormat:@"0%ld",(long)self.day];
    }else{
        return [NSString stringWithFormat:@"%ld",(long)self.day];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) hour {
    NSDateComponents* components = [self dateComponents];
    return [components hour];
}
- (NSString *)hourStr{
    if (self.hour < 10) {
        return  [NSString stringWithFormat:@"0%ld",(long)self.hour];
    }else{
        return [NSString stringWithFormat:@"%ld",(long)self.hour];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) minute {
    NSDateComponents* components = [self dateComponents];
    return [components minute];
}
- (NSString *)minuteStr{
    if (self.minute < 10) {
        return  [NSString stringWithFormat:@"0%ld",(long)self.minute];
    }else{
        return [NSString stringWithFormat:@"%ld",(long)self.minute];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) second {
    NSDateComponents* components = [self dateComponents];
    return [components second];
}

- (NSInteger) weekDay {
    NSDateComponents* components = [self dateComponents];
    return [components weekday];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDateComponents*) dateComponents {
    
    static dispatch_once_t onceToken;
    static NSCalendar *calendar;
    static NSInteger unitFlags;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
    });
    
    NSDateComponents *sharedComponents = [calendar components:unitFlags fromDate: self];;
    return sharedComponents;
}

- (BOOL) isTodayDate {
    return [self compareDate: [NSDate date]] == NSOrderedSame;
}

// TODO: 左操作数比右操作数大称为Ascending，不太好
//
// 如果当前的日期比给定的date大，则返回: NSOrderedAscending
//
- (NSComparisonResult) compareDate:(NSDate*) date {
    // 比较两个日期是不是同一天
    
    NSDateComponents *comps1 = [self dateComponents];
    NSDateComponents *comps2 = [date dateComponents];
    NSInteger selfIntValue = [comps1 year]*10000 + [comps1 month]*100 + [comps1 day];
    NSInteger dateIntValue = [comps2 year]*10000 + [comps2 month]*100 + [comps2 day];
    
    if (selfIntValue > dateIntValue) {
        return NSOrderedDescending;
    } else if(selfIntValue < dateIntValue){
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)compareDate2:(NSDate *)date {
    return [date compareDate:self];
}

- (NSInteger) daysOverLastDate:(NSDate*) date {
    NSDateFormatter* formattor = [[NSDateFormatter alloc] init];
    [formattor setDateFormat: @"yyyy-MM-dd"];
    NSString* dateStr = [NSString stringWithFormat: @"%@ 00:00:00", [formattor stringFromDate: self]];
    NSString* lastDateStr = [NSString stringWithFormat: @"%@ 00:00:00", [formattor stringFromDate: date]];
    
    NSDateFormatter* newFormattor = [[NSDateFormatter alloc] init];
    [newFormattor setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* newDate = [newFormattor dateFromString: dateStr];
    NSDate* lastNewDate = [newFormattor dateFromString: lastDateStr];
    
    NSTimeInterval time = [newDate timeIntervalSinceDate: lastNewDate];
    return (NSInteger)(time+1)/(24*60*60);
}


- (NSDate *)dateAtHour:(NSInteger)hour minute:(NSInteger)minute {
    NSDateComponents *comps = [self dateComponents];
    [comps setHour:hour];
    [comps setMinute:minute];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:comps];
}

- (NSDate *)yesterday {
    return [NSDate dateWithTimeInterval:-24*3600 sinceDate:self];
}

- (NSDate *)tomorrow {
    return [NSDate dateWithTimeInterval:24*3600 sinceDate:self];
}

- (NSDate *)getLocalTime
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

@end
