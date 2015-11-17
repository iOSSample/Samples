//
//  MyTabBarItem.h
//  BSKWatch
//
//  Created by DuHao on 15/5/13.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarItem : UITabBarItem{
    UILabel *badgeLabel;
    NSString *imageName;
    NSString *selectImageName;
}
//@property(nonatomic,strong)UILabel *badgeLabel;
@property(nonatomic,strong)NSString *badgeStr;
@property(nonatomic,strong)UIColor *badgeColor;

- (void)showBadge:(BOOL)isshow;
@end
