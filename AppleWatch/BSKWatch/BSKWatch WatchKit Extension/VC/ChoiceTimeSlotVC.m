//
//  ChoiceTimeSlotVC.m
//  BSKWatch
//
//  Created by DuHao on 15/5/14.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ChoiceTimeSlotVC.h"
#import "recordTimeCell.h"
#import "BSKTool.h"
@interface ChoiceTimeSlotVC (){
    NSArray *titleArray;
    NSString *selectStr;
    NSInteger point;
}

@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;
@end

@implementation ChoiceTimeSlotVC

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"---%@",context);
    
    selectStr = context;
    
    titleArray = [BSKTool getTimeSlotArray];
    
    [self.tableView setNumberOfRows:titleArray.count withRowType:@"recordtimecell"];
    
    for (NSInteger i = 0; i < self.tableView.numberOfRows; i++) {
        recordTimeCell* theRow = [self.tableView rowControllerAtIndex:i];
        [theRow.timeTpyeLabel setText:[titleArray objectAtIndex:i]];
        //默认选中行
        if ([selectStr isEqualToString:[titleArray objectAtIndex:i]]) {
            [theRow.backGroup setBackgroundColor:[UIColor redColor]];
            point = i;
        }else{
            [theRow.backGroup setBackgroundColor:NormalColor];
        }
    }
}

- (void)willActivate {
    [super willActivate];
    
}

- (void)didDeactivate {
    [super didDeactivate];
    titleArray = nil;
    
    
}
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    
    NSString *str = [titleArray objectAtIndex:rowIndex];
    
    if ([selectStr isEqualToString:str]) {
        [self popController];
    }else{
        
        recordTimeCell* theRow = [self.tableView rowControllerAtIndex:point];
        [theRow.backGroup setBackgroundColor:[UIColor lightGrayColor]];
        
        recordTimeCell *selectRow = [self.tableView rowControllerAtIndex:rowIndex];
        [selectRow.backGroup setBackgroundColor:[UIColor redColor]];
        
        point = rowIndex;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"seleceedTimeType" object:[titleArray objectAtIndex:rowIndex] userInfo:nil];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.25f * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"延迟后执行");
            [self popController];
        });
    }
    
}
@end



