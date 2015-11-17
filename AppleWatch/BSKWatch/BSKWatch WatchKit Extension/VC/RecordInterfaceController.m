//
//  RecordInterfaceController.m
//  BSKWatch
//
//  Created by DuHao on 15/5/5.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//
#import "BSKTool.h"

#import "RecordInterfaceController.h"
#import "TestTimeSlotCell.h"
#import "TestDateCell.h"
#import "ChoiceTimeSlotVC.h"
#import "RecordMode.h"

@interface RecordInterfaceController ()<TestDateCellDelegate,TestTimeSlotCellDelegate>{
    NSArray *titleArray;
    TestTimeSlotCell *timeSlotCell;
    TestDateCell *testDateCell;
    RecordMode *recordMode;
}
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;
@end

@implementation RecordInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    
    titleArray = [BSKTool getTimeSlotArray];
    
    recordMode = [[RecordMode alloc] init];
    NSDictionary *info = [BSKTool getTimeSlotType];
    recordMode.bloodSugarType = [info objectForKey:@"type"];
    recordMode.timeSlotName = [info objectForKey:@"time"];
    
    [self.tableView setRowTypes:@[@"cellone",@"celltwo",@"cellthree"]];
    
    testDateCell = [self.tableView rowControllerAtIndex:0];
    testDateCell.delegate = self;
    timeSlotCell = [self.tableView rowControllerAtIndex:2];
    [timeSlotCell setTimeSlotStr:recordMode.timeSlotName];
    timeSlotCell.delegate = self;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
    if (timeSlotCell != nil) {
        [timeSlotCell setTimeSlotStr:recordMode.timeSlotName];

    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    NSLog(@"选中%ld",rowIndex);
    
}
#pragma mark -  点击  修改日期
- (void)sendClickTimeDateAction{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChangeDateNiti:) name:@"NotificationChangeSugerDate" object:nil];
    [self pushControllerWithName:@"ChangeYearVC" context:nil];
}
#pragma mark - 修改了  日期的通知
- (void)getChangeDateNiti:(NSNotification *)notification{
    
}
#pragma mark -  点击 修改 时间段
- (void)sendClickTimeSlotAction{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choiceTimeSlotNotifica:) name:@"seleceedTimeType" object:nil];
    [self pushControllerWithName:@"ChoiceTimeSlot" context:recordMode.timeSlotName];
}

#pragma mark -  选择 时间段
- (void)choiceTimeSlotNotifica:(NSNotification *)notification{
    NSString *selectName = notification.object;
    recordMode.timeSlotName = selectName;
    recordMode.bloodSugarType = [BSKTool getBloodSugarTimeType:selectName];
    
    //移除注册的通知观察
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"seleceedTimeType" object:nil];
    
}

@end



