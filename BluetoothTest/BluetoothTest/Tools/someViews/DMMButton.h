//
//  DMMButton.h
//  DiabetesManagement
//
//  Created by 杜豪 on 15/5/20.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kFilledBtnGreen = 0,         //绿色边框
    kFilledBtnGray,                 //灰色边框
    kFilledBtnRed,                  //红色边框
//    kFilledBtnGrayFilled,           // 填充灰色
//    kFilledBtnRedFilled,            // 填充红色
    kFilledBtnNone
    
} FilledColorTyle;

@interface DMMButton : UIButton{
    UIColor* _backGroundColor;
    UIColor* _borderColor;
    UIColor* _textColor;
    UILabel* _titleLabel;
    
    NSInteger _fontSize;
    BOOL _isBold;
}

//- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andColor:(UIColor *)bcolor;

- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle) type title:(NSString*) title;
- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle)type title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;
- (id) initWithFrame:(CGRect)frame color:(UIColor*)color borderColor:(UIColor*)borderColor textClolr:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;



// 初始化之后还能做修改
- (void) setTitle:(NSString *)title;
- (void) bindType:(FilledColorTyle) type title:(NSString*) title;
- (void) bindColor:(UIColor*)color borderColor:(UIColor*)borderColor textClolr:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;
- (void)setTitleFont:(UIFont *)titleFont;

//获取btn上的title
- (NSString *)getTitle;

@end

