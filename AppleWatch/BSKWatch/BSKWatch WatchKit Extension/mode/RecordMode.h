//
//  RecordMode.h
//  BSKWatch
//
//  Created by DuHao on 15/5/14.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordMode : NSObject
/*    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.sugerDateTextField.text, @"bloodSugarValue", self.mealType, @"bloodSugarType" ,dateStr, @"testDateTime", nil];
 */
@property(strong, nonatomic)NSString *bloodSugarValue;   //血糖值
@property(strong, nonatomic)NSString *bloodSugarType;    //时间段
@property(strong, nonatomic)NSString *testDateTime;      //测量时间

@property(strong,nonatomic)NSString *timeSlotName;       //时间段的名字 (上传用不到)
@end
