//
//  UIImageView+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UIImageView+DH.h"

@implementation UIImageView (DH)
+ (UIImageView*) imageViewWithImagePath: (NSString*)bundleImage {
    UIImage* image = [UIImage imageNamed:bundleImage];
    return [[UIImageView alloc] initWithImage:image];
}

+ (UIImageView*) imageViewWithImage: (UIImage*)image {
    return [[UIImageView alloc] initWithImage:image];
}

+ (UIImageView*) imageViewWithImagePath: (NSString*)bundleImage andFrame: (CGRect)frame {
    UIImage* image = [UIImage imageNamed:bundleImage];
    UIImageView* view = [[UIImageView alloc] initWithImage:image];
    view.frame = frame;
    
    return view;
}

+ (UIImageView*) imageViewWithImage: (UIImage*)image andFrame: (CGRect)frame {
    UIImageView* view = [[UIImageView alloc] initWithImage:image];
    view.frame = frame;
    
    return view;
}
@end
