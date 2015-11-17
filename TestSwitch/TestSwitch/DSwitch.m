//
//  DSwitch.m
//  TestSwitch
//
//  Created by DuHao on 15/4/30.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//
#define DefaultOnColor  [UIColor greenColor]
#define DefaultOffColor [UIColor whiteColor]

#import "DSwitch.h"
//右边是打开 左边是关闭
@implementation DSwitch{
    CGFloat circleOnLeft;
    CGFloat circleOffLeft;
    CGFloat circleWidth;
    BOOL hasInit;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        hasInit = NO;
        /*默认打开的状态*/
        self.isOn = YES;
        
        circleWidth = frame.size.height - 1.0f;
        self.layer.cornerRadius = frame.size.height/2.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
//        [UIColor whiteColor];
        self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        
        circleOnLeft = frame.size.width - 0.5f - circleWidth;
        circleOffLeft = 0.5f;
        
        self.circle = [[UIView alloc] initWithFrame:CGRectMake(circleOnLeft, 0.5f, circleWidth, circleWidth)];
        self.circle.layer.cornerRadius = circleWidth/2.0f;
        self.circle.clipsToBounds = YES;
        self.circle.layer.borderWidth = 0.5f;
        self.circle.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.circle.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.circle];
        
        self.backgroundColor = DefaultOnColor;
        
        self.onColor = DefaultOnColor;
        self.offColor = DefaultOffColor;
        UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
        [button addTarget:self action:@selector(ChangeStues:) forControlEvents:UIControlEventTouchUpInside];
        
        hasInit = YES;
    }
    return self;
}
/**
 *  设置圆的颜色
 *
 *  @param circleColor
 */
- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    self.circle.backgroundColor = circleColor;
}
/**
 *  设置打开时的背景色
 *
 *  @param onColor
 */
- (void)setOnColor:(UIColor *)onColor{
    _onColor = onColor;
    if (self.isOn) {
        if (hasInit) {
            self.backgroundColor = onColor;
        }
    }
}
/**
 *  设置关闭时的背景色
 *
 *  @param offColor
 */
- (void)setOffColor:(UIColor *)offColor{
    _offColor = offColor;
    if (!self.isOn) {
        if (!hasInit) {
            self.backgroundColor = offColor;
        }
    }
}
- (void)ChangeStues:(id)sender{
    if (self.isOn) {
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.circle.left = circleOffLeft;
            self.backgroundColor = self.offColor;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.circle.left = circleOnLeft;
            self.backgroundColor = self.onColor;
        } completion:^(BOOL finished) {
            
        }];
    }
    self.isOn = !self.isOn;
}
@end
