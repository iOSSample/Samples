//
//  UITabBar+Badge.m
//  TestOne
//
//  Created by 杜豪 on 15/6/16.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UITabBar+Badge.h"

#define TabbarItemNums 3.0    //tabbar的数量

@implementation UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index{
    
    [self removeBadgeOnItemIndex:index];
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    float percentX = (index +0.6) / TabbarItemNums;
    // ceilf() 返回大于或者等于指定表达式的最小整数
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    
    badgeView.frame = CGRectMake(x, y, 10, 10);
    
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
