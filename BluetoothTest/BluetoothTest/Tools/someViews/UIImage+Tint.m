//
//  UIImage+Tint.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)
- (UIImage*) imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor: tintColor blendMode:kCGBlendModeDestinationIn];
}


- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor: tintColor blendMode:kCGBlendModeOverlay];
}


- (UIImage*) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode) blendMode {
    DHLogMethodName();
    
    // keep alpha, set opaque to NO
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage* tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size {
    
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
