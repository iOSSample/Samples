//
//  BSKTool.m
//  BSKWatch
//
//  Created by DuHao on 15/5/11.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "BSKTool.h"
#import "NSDate+DH.h"


@implementation ImageNameRange
@end


@implementation BSKTool
+(ImageNameRange *)getImageRange:(int)nowP toPoint:(int)toP{
    ImageNameRange *nameRange = [[ImageNameRange alloc] init];
    if (nowP < toP) {//圆环 角度 》增加
        nameRange.imageName = @"progress+";
        nameRange.range = NSMakeRange(nowP, toP);
        
    }else if (nowP > toP){//圆环 角度《 减小
        nameRange.imageName = @"progress-";
        nameRange.range = NSMakeRange(nowP, toP);
    }else{
        return nil;
    }
    return nameRange;
}

+(NSArray *)getTimeSlotArray{
    return [NSArray arrayWithObjects:@"早餐前",@"早餐后",@"午餐前",@"午餐后",@"晚餐前",@"晚餐后",@"睡 前",@"凌 晨", nil];
}
+ (NSDictionary *)getTimeSlotType{
    NSString *mealType;
    NSString *recordTime;
    
    //默认测量日期
    NSDate *date = [NSDate date];
    NSInteger hour = date.hour;
    if (hour > 0 && hour < 5){
        mealType = @"17";
        recordTime = @"凌 晨";
    }else if (hour >= 5 && hour < 7){
        mealType = @"10";
        recordTime = @"早餐前";
    }else if (hour >= 7 && hour < 11){
        mealType = @"11";
        recordTime = @"早餐后";
    }else if (hour >= 11 && hour < 12){
        mealType = @"12";
        recordTime = @"午餐前";
    }else if (hour >= 12 && hour < 17){
        mealType = @"13";
        recordTime = @"午餐后";
    }else if (hour >= 17 && hour < 18){
        mealType = @"14";
        recordTime = @"晚餐前";
    }else if (hour >= 18 && hour < 21){
        mealType = @"15";
        recordTime = @"晚餐后";
    }else{
        mealType = @"16";
        recordTime = @"睡 前";
    }
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:mealType,@"type",recordTime,@"time", nil];
    return info;
}
+ (NSString *)getBloodSugarTimeType:(NSString *)timeSolt{
    if ([timeSolt isEqualToString:@"早餐前"]) {
        return @"10";
    }
    if ([timeSolt isEqualToString:@"早餐后"]) {
        return @"11";
    }
    if ([timeSolt isEqualToString:@"午餐前"]) {
        return @"12";
    }
    if ([timeSolt isEqualToString:@"午餐后"]) {
        return @"13";
    }
    if ([timeSolt isEqualToString:@"晚餐前"]) {
        return @"14";
    }
    if ([timeSolt isEqualToString:@"晚餐后"]) {
        return @"15";
    }
    if ([timeSolt isEqualToString:@"睡 前"]) {
        return @"16";
    }
    if ([timeSolt isEqualToString:@"凌 晨"]) {
        return @"17";
    }
   
    return nil;
}
@end
