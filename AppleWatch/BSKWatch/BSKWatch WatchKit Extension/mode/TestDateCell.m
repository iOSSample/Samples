//
//  TestDateCell.m
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "TestDateCell.h"

@implementation TestDateCell

- (IBAction)onClickBtnAction {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(sendClickTimeDateAction)]) {
            [self.delegate sendClickTimeDateAction];
        }
        
    }
}

@end
