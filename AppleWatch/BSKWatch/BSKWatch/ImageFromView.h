//
//  ImageFromView.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/17.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageFromView : NSObject
/**
 *  获取一个UIImage:从一个UIVIew,(把一个UIVIew转化成UIImage)
 *
 *  @param theView 要转化的UIIView
 *
 *  @return 返回结果UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView;   
@end
