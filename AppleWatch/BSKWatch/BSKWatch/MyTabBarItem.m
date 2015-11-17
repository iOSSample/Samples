//
//  MyTabBarItem.m
//  BSKWatch
//
//  Created by DuHao on 15/5/13.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "MyTabBarItem.h"
#import "ImageFromView.h"

#define DefaultBadgeColor [UIColor redColor]

@implementation MyTabBarItem
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
    if (self) {
//        badgeLabel = [[UILabel alloc] init];
    }
    return self;
}
- (void)setBadgeStr:(NSString *)badgeStr{
    _badgeStr = badgeStr;
    if (!badgeLabel) {
        badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 8)];
        badgeLabel.textAlignment = NSTextAlignmentRight;
        badgeLabel.font = [UIFont systemFontOfSize:7];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.backgroundColor = DefaultBadgeColor;
    }
    if (badgeStr == nil) {
        badgeLabel.frame = CGRectMake( 42, 0, 2, 2);
        badgeLabel.layer.cornerRadius = 1.0f;
        badgeLabel.layer.masksToBounds = YES;
    }else{
        badgeLabel.text = badgeStr;
        badgeLabel.layer.cornerRadius = 2.0f;
        badgeLabel.layer.masksToBounds = YES;
        [badgeLabel sizeToFit];
        CGFloat bw = badgeLabel.frame.size.width;
        badgeLabel.frame = CGRectMake(44.0f - bw, 0, bw, 8);
    }
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [temp addSubview:[[UIImageView alloc] initWithImage:self.image]];
    [temp addSubview:badgeLabel];
    self.image = [ImageFromView imageFromView:temp];
    
}

@end
