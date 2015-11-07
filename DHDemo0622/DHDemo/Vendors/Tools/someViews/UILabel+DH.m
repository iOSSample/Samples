//
//  UILabel+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UILabel+DH.h"

@implementation UILabel (DH)
+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (CGFloat) fontsize
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (CGFloat) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (CGFloat) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: fontsize];
    
    return label;
}
@end
