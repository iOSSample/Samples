//
//  UITabBar+Badge.h
//  TestOne
//
//  Created by 杜豪 on 15/6/16.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;

- (void)hideBadgeOnItemIndex:(int)index;

- (void)removeBadgeOnItemIndex:(int)index;

@end
