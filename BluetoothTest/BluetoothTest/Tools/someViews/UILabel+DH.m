//
//  UILabel+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UILabel+DH.h"

@implementation UILabel (DH)
+ (id) labelWithFrame: (CGRect)frame andBkColor: (UIColor*) color haveTopLine:(BOOL)istopLine haveBotttomLine:(BOOL)isBottomLine haveLeftLine:(BOOL)isLeftLine havcRightLine:(BOOL)isRightLine haveLeftAll:(BOOL)leftAll haveRightAll:(BOOL)rightAll{
    UILabel * label = [[UILabel alloc] initWithFrame: frame];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = color;
    if (istopLine) {
        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5f)];
        topLine.backgroundColor = [UIColor blackColor];
        [label addSubview:topLine];
    }
    if (isBottomLine) {
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        bottomLine.backgroundColor = [UIColor blackColor];;
        [label addSubview:bottomLine];
    }
    if (isLeftLine) {
        UILabel *leftLine = [[UILabel alloc] init];
        if (leftAll) {
            leftLine.frame = CGRectMake(0.5f, 0, 0.5f, frame.size.height);
        }
        else
        {
            leftLine.frame = CGRectMake(0.5f, 3, 0.5f, frame.size.height-3);
        }
        leftLine.backgroundColor = [UIColor blackColor];
        [label addSubview:leftLine];
    }
    if (isRightLine) {
        UILabel *rightLine = [[UILabel alloc] init];
        if (rightAll) {
            rightLine.frame = CGRectMake(frame.size.width-1.0f, 0, 0.5f, frame.size.height);

        }
        else
        {
            rightLine.frame = CGRectMake(frame.size.width-1.0f, 5,0.5f, frame.size.height-5);

        }
        rightLine.backgroundColor = [UIColor blackColor];
        [label addSubview:rightLine];
    }
    return label;
}

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
+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (CGFloat) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text
              textAlignment:(NSTextAlignment)alignment{
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    label.textAlignment = alignment;
    return label;
}
@end
