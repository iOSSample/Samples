//
//  UIWindow+DH.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIWindow (DH)
/**
 * Searches the view hierarchy recursively for the first responder, starting with this window.
 */
- (UIView*)findFirstResponder;

/**
 * Searches the view hierarchy recursively for the first responder, starting with topView.
 */
- (UIView*)findFirstResponderInView:(UIView*)topView;
@end
