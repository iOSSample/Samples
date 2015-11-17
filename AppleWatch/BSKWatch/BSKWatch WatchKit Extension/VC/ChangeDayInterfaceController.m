//
//  ChangeDayInterfaceController.m
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ChangeDayInterfaceController.h"
#import "NSDate+DH.h"

<<<<<<< HEAD
@interface ChangeDayInterfaceController ()
=======
@interface ChangeDayInterfaceController (){
    NSNumber *year;
    NSNumber *month;
    
}
>>>>>>> origin/master
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;

@end

@implementation ChangeDayInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    NSDictionary *getInfo = context;
    year = [getInfo objectForKey:@"year"];
    month = [getInfo objectForKey:@"month"];

    NSDate *date = [NSDate date];
    NSInteger rowNumber = 0;
    //判断 年月 显示几天 年月相等显示几天
    if ([year integerValue] == date.year && [month integerValue] == date.month) {
        rowNumber = date.day;
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM"];
        NSDate *theDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@",year,month]];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                       inUnit:NSCalendarUnitMonth
                                      forDate:theDate];
        rowNumber= range.length;
    }
    NSLog(@"%@-%@-%ld",year,month,rowNumber);

    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



