//
//  ChangeYearInterfaceController.m
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//
#import "BSKTool.h"
#import "ChangeYearInterfaceController.h"
#import "YearCell.h"
#import "NSDate+DH.h"

@interface ChangeYearInterfaceController (){
    NSMutableArray *yearArray;
    NSInteger year;
}
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;

@end

@implementation ChangeYearInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSDate *nowDate = [NSDate date];
    NSInteger nowYear = nowDate.year;
    year = nowDate.year;
    
    yearArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i ++) {
        NSNumber *number = [NSNumber numberWithInteger:nowYear - i];
        [yearArray addObject:number];
    }
    
    
    [self.tableView setNumberOfRows:yearArray.count withRowType:@"yearCell"];
    
    for (NSInteger i = 0; i < self.tableView.numberOfRows; i++) {
        YearCell* theRow = [self.tableView rowControllerAtIndex:i];
        [theRow.yearLabel setText:[NSString stringWithFormat:@"%@年",[yearArray objectAtIndex:i]]];
        
//        //默认选中行
        if (year  ==[[yearArray objectAtIndex:i] integerValue]) {
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
    
    year = [[yearArray objectAtIndex:rowIndex] integerValue];
    
    [self pushControllerWithName:@"ChangeMonthVC" context:[NSNumber numberWithInteger:year]];
}
@end



