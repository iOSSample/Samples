//
//  UILabel+DH.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DH)
// 创建一个指定frame和字体的label
// 背景为透明，左对其, 颜色为系统默认(应该时黑色)
+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (CGFloat) fontsize text: (NSString*) text;
+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (CGFloat) fontsize fontColor: (UIColor*) color text: (NSString*) text;

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text;

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (CGFloat) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text;
@end
