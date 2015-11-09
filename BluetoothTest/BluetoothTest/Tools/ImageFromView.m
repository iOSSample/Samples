//
//  ImageFromView.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/17.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "ImageFromView.h"

@implementation ImageFromView
+ (UIImage *)imageFromView:(UIView *)theView{
    UIGraphicsBeginImageContextWithOptions(theView.size, NO, 0.0);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
