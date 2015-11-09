//
//  UIView+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UIView+DH.h"

@implementation UIView (DH)
+ (id) viewWithFrame: (CGRect)frame andBkColor: (UIColor*) color {
    UIView * view = [[UIView alloc] initWithFrame: frame];
    view.backgroundColor = color;
    return view;
}
+ (id) viewWithFrame: (CGRect)frame andBkColor: (UIColor*) color haveTopLine:(BOOL)istopLine haveBotttomLine:(BOOL)isBottomLine{
    UIView * view = [[UIView alloc] initWithFrame: frame];
    view.backgroundColor = color;
    if (istopLine) {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5f)];
        topLine.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:topLine];
    }
    if (isBottomLine) {
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:bottomLine];
    }
    return view;
}
/**
 *  快速生成一个可带圆角 边框的view
 *
 *  @param frame        frame
 *  @param bgcolor      背景颜色
 *  @param borderWidth  边框的宽度 0 表示没有边框
 *  @param borderColor  边框的颜色
 *  @param cornerRadius 圆角的大小  0 表示没有圆角
 *
 *  @return
 */
+ (id)viewWithFrame:(CGRect)frame
         andBkColor:(UIColor *)bgcolor
     andBorderWidth:(CGFloat)borderWidth
     andBorderColor:(UIColor *)borderColor
    andCornerRadius:(CGFloat)cornerRadius{
    
    UIView * view = [[UIView alloc] initWithFrame: frame];
    view.backgroundColor = bgcolor;
    //边框
    if (borderWidth > 0) {
        view.layer.borderWidth = borderWidth;
    }
    //边框颜色
    if (borderColor != nil && borderWidth > 0) {
        view.layer.borderColor = borderColor.CGColor;
    }
    //圆角
    if (cornerRadius > 0 && cornerRadius < frame.size.height && cornerRadius < frame.size.width) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = cornerRadius;
    }
    return view;
}
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)orientationWidth {
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orient)
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orient)
    ? self.width : self.height;
}

- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) {
            return childView;
        }
        
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) {
            return result;
        }
    }
    return nil;
}

//
// 创建一个指定大小，指定颜色的UIView
//
+ (UIView*) createViewWithFrame: (CGRect)frame andBackground: (UIColor*) bkColor {
    UIView* view = [[UIView alloc] initWithFrame: frame];
    view.backgroundColor = bkColor;
    return view;
}

@end
