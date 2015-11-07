//
//  UIImage+Tint.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)
- (UIImage*) imageWithTintColor:(UIColor*) tintColor;
- (UIImage*) imageWithGradientTintColor:(UIColor*) tintColor;

+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size ;
@end
