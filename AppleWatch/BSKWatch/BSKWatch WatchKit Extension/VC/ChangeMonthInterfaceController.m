//
//  ChangeMonthInterfaceController.m
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ChangeMonthInterfaceController.h"
#import "NSDate+DH.h"
#import "BSKTool.h"
#import "MonthCell.h"
@interface ChangeMonthInterfaceController (){
    NSMutableArray *monthArray;
    NSInteger month;
    NSNumber *year;
}


@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;
@end

@implementation ChangeMonthInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    year = context;
    [self setTitle:[NSString stringWithFormat:@"%@年",year]];
    NSInteger yearInt = [year integerValue];
    NSDate *nowDate = [NSDate date];
    month = nowDate.month;

    NSInteger allNumber = 12;
    if (nowDate.year == yearInt) {
        allNumber = month;
    }
    
    monthArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= allNumber; i ++) {
        NSNumber *number = [NSNumber numberWithInteger:i];
        [monthArray addObject:number];
    }
    
    
    [self.tableView setNumberOfRows:monthArray.count withRowType:@"monthCell"];
    
    for (NSInteger i = 0; i < self.tableView.numberOfRows; i++) {
        MonthCell* theRow = [self.tableView rowControllerAtIndex:i];
        [theRow.monthLable setText:[NSString stringWithFormat:@"%@月",[monthArray objectAtIndex:i]]];
        
        //        //默认选中行
        if (month  ==[[monthArray objectAtIndex:i] integerValue]) {
            [theRow.groupBack setBackgroundColor:HighlightedColor];
        }else{
            [theRow.groupBack setBackgroundColor:NormalColor];
        }
    }
    //    [self.tableView scrollToRowAtIndex:<#(NSInteger)#>];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    NSDictionary *pushInfo = [NSDictionary dictionaryWithObjectsAndKeys:year,@"year",[monthArray objectAtIndex:rowIndex],@"month", nil];
    [self pushControllerWithName:@"ChangeDayVC" context:pushInfo];
}
@end



