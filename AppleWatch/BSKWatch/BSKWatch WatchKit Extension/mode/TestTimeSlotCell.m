//
//  TestTimeSlotCell.m
//  BSKWatch
//
//  Created by DuHao on 15/5/14.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "TestTimeSlotCell.h"

@implementation TestTimeSlotCell

- (IBAction)onClickTimeSlotAction {
    if (self.delegate) {
        [self.delegate sendClickTimeSlotAction];
    }
}
- (void)setTimeSlotStr:(NSString *)timeSlotStr{
    _timeSlotStr = timeSlotStr;
    if (self.timeSlotBtn) {
        [self.timeSlotBtn setTitle:timeSlotStr];
    }
}
@end
