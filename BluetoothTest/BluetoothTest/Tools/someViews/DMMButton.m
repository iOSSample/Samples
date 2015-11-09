//
//  DMMButton.m
//  DiabetesManagement
//
//  Created by 杜豪 on 15/5/20.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import "DMMButton.h"
//省缺字体大小
static const CGFloat kBtnTitleFontSize = 16;


@implementation DMMButton
//舍弃
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andColor:(UIColor *)bcolor{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:bcolor forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        //边框 圆角
        if (frame.size.height > 4.0f) {
            self.layer.cornerRadius = 4.0f;
            self.layer.masksToBounds = YES;
        }
        
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = bcolor.CGColor;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle)type title:(NSString *)title
            fontSize:(NSInteger) size isBold:(BOOL) isbold {
    _fontSize = size;
    _isBold = isbold;
    self = [self initWithFrame: frame type:type title:title];
    if (self) {
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle) type title:(NSString*) title {
    
    // 字体大小 和 自己加粗设定缺省
    if (_fontSize == 0) {
        _isBold = YES;
        _fontSize = kBtnTitleFontSize;
    }
    
    [self setBtnStyleWithType: type];
    
    self = [self initWithFrame: frame
                         color: _backGroundColor
                   borderColor: _borderColor
                     textClolr: _textColor
                         title: title
                      fontSize: _fontSize
                        isBold: _isBold];
    if (self) {
        
    }
    return self;
    
}
/**
 *
 *  @param frame
 *  @param color       背景颜色
 *  @param borderColor 边框颜色
 *  @param textColor   字体颜色
 *  @param title       文字
 *  @param size        字号
 *  @param isbold      字体是否是粗体
 *
 *  @return
 */
- (id) initWithFrame:(CGRect)frame
               color:(UIColor*)color
         borderColor:(UIColor*)borderColor
           textClolr:(UIColor*)textColor
               title:(NSString *)title
            fontSize:(NSInteger) size
              isBold:(BOOL) isbold {
    
    self = [super initWithFrame: frame];
    if (self) {
        
        _backGroundColor = color;
        _borderColor = borderColor;
        _textColor = textColor;
        _fontSize = size;
        _isBold = isbold;
        
        _titleLabel = [UILabel labelWithFrame: CGRectMake(0, (CGRectGetHeight(frame) - kBtnTitleFontSize-1)/2, CGRectGetWidth(frame), kBtnTitleFontSize+1)
                                 boldFontSize: _fontSize
                                    fontColor: _textColor
                                         text: title];
        if (!_isBold) {
            _titleLabel.font = [UIFont systemFontOfSize: _fontSize];
        }
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _titleLabel];
        
        
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 4.0f;
        self.layer.borderColor = _borderColor.CGColor;
        self.backgroundColor = _backGroundColor;
    }
    return self;
}

//
// 设置一些颜色
//
- (void) setBtnStyleWithType:(FilledColorTyle) type {
    switch (type) {
        case kFilledBtnGreen: {                         //绿色边框
            _backGroundColor = RGBCOLOR_HEX(0xffffff);  //白色
            _borderColor = RGBCOLOR_HEX(0x099f57);      //绿色边框
            _textColor = _borderColor;                  //字体颜色 = 边框
        }
            break;
            
        case kFilledBtnGray: {             //灰色边框
            _backGroundColor = [UIColor whiteColor];        //背景 白色
            _borderColor = RGBCOLOR_HEX(0x787978);          //边框 灰色
            _textColor = RGBCOLOR_HEX(0x787978);            //字体灰色
            _isBold = NO;
        }
            break;
        case kFilledBtnRed: {     //红色边框
            
            _backGroundColor = [UIColor whiteColor];
            _borderColor = RGBCOLOR_HEX(0xea4e1d);      //边框 红色
            _textColor = RGBCOLOR_HEX(0xea4e1d);
        }
            break;
//        case kFilledBtnGrayFilled: {
//            _backGroundColor = RGBCOLOR_HEX(0x888888);
//            _borderColor = RGBCOLOR_HEX(0x888888);
//            _textColor = [UIColor whiteColor];
//        }
//            break;
//            
//        case kFilledBtnRedFilled: {
//            _backGroundColor = RGBCOLOR_HEX(0xff5556);
//            _borderColor = RGBCOLOR_HEX(0xff5556);
//            _textColor = [UIColor whiteColor];
//        }
//            break;
        case kFilledBtnNone: {
            
        }
            
        default:
            break;
    }
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    //如果边框的颜色 等于 背景颜色  取 字体颜色 ,其他不一样  取边框颜色
    UIColor *highlightedBackColoe = [_borderColor isEqual: _backGroundColor] ? _textColor : _borderColor;
    //设置背景颜色
    self.backgroundColor = highlighted ? highlightedBackColoe : _backGroundColor;
    
    UIColor *highlightedTextColor = [_backGroundColor isEqual: [UIColor clearColor]] ? [UIColor grayColor] : _backGroundColor;
    _titleLabel.textColor = highlighted ? highlightedTextColor : _textColor;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (void)setTitleFont:(UIFont *)titleFont{
    _titleLabel.font = titleFont;
}
- (void) bindType:(FilledColorTyle) type title:(NSString*) title {
    [self setBtnStyleWithType: type];
    [self updateDisplay];
    [self setTitle: title];
    
}

- (void) bindColor:(UIColor*)color borderColor:(UIColor*)borderColor textClolr:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold {
    
    _backGroundColor = color;
    _borderColor = borderColor;
    _textColor = textColor;
    _fontSize = size;
    _isBold = isbold;
    
    [self updateDisplay];
    [self setTitle: title];
}

//
// 重绘颜色
//
- (void) updateDisplay {
    _titleLabel.textColor = _textColor;
    _titleLabel.font = _isBold ? [UIFont boldSystemFontOfSize: _fontSize] : [UIFont systemFontOfSize: _fontSize];
    _titleLabel.textColor = _textColor;
    
    self.layer.borderColor = _borderColor.CGColor;
    self.backgroundColor = _backGroundColor;
}

- (NSString *)getTitle {
    return _titleLabel.text;
}

@end
