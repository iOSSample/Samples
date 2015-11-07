//
//  UIImageView+DH.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DH)
+ (UIImageView*) imageViewWithImagePath: (NSString*)bundleImage;
+ (UIImageView*) imageViewWithImage: (UIImage*)image;

+ (UIImageView*) imageViewWithImagePath: (NSString*)bundleImage andFrame: (CGRect)frame;
+ (UIImageView*) imageViewWithImage: (UIImage*)image andFrame: (CGRect)frame;
@end
