//
//  BSKTool.h
//  BSKWatch
//
//  Created by DuHao on 15/5/11.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NormalColor [UIColor grayColor]
#define HighlightedColor [UIColor redColor]

@interface ImageNameRange :NSObject

@property(nonatomic,strong)NSString *imageName;

@property(nonatomic)NSRange range;

@end

@interface BSKTool : NSObject


+(NSArray *)getTimeSlotArray;
+ (NSDictionary *)getTimeSlotType;
+ (NSString *)getBloodSugarTimeType:(NSString *)timeSolt;
@end
