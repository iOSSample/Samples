//
//  DSwitch.h
//  TestSwitch
//
//  Created by DuHao on 15/4/30.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DH.h"
@interface DSwitch : UIView

@property(nonatomic)BOOL isOn;

@property(nonatomic,strong)NSString *onText;

@property(nonatomic,strong)NSString *offText;
//圆点
@property(nonatomic,strong)UIView *circle;
//圆点颜色
@property(nonatomic,strong)UIColor *circleColor;
//打开的背景色
@property(nonatomic,strong)UIColor *onColor;
//关闭的背景色
@property(nonatomic,strong)UIColor *offColor;
//边框的颜色
@property(nonatomic,strong)UIColor *borderColor;

@end
