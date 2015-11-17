//
//  TestTimeSlotCell.h
//  BSKWatch
//
//  Created by DuHao on 15/5/14.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@protocol TestTimeSlotCellDelegate <NSObject>

- (void)sendClickTimeSlotAction;

@end

@interface TestTimeSlotCell : NSObject

@property(strong,nonatomic)NSString *timeSlotStr;

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *leftLabel;

@property (strong, nonatomic) IBOutlet WKInterfaceButton *timeSlotBtn;

@property(weak, nonatomic)id<TestTimeSlotCellDelegate>delegate;

- (IBAction)onClickTimeSlotAction;

@end
