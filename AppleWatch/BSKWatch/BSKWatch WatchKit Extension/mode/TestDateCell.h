//
//  TestDateCell.h
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@protocol TestDateCellDelegate <NSObject>

- (void)sendClickTimeDateAction;

@end


@interface TestDateCell : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupBack;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *changeBtn;

@property (weak,nonatomic) id<TestDateCellDelegate>delegate;

- (IBAction)onClickBtnAction;


@end
