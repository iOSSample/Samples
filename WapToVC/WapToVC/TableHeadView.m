//
//  TableHeadView.m
//  WapToVC
//
//  Created by 杜豪 on 15/8/10.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "TableHeadView.h"

static CGFloat const kSectionHeight = 11;

static CGFloat kTopImageHeight = 1000;

@implementation TableHeadView{
    UIImageView *_imageView;        // 背景大图
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
//        UIView *imageBackView = [[UIView alloc]initWithFrame: CGRectMake(0, -kTopImageHeight, frame.size.width , frame.size.height + kTopImageHeight - kSectionHeight)];
//        imageBackView.backgroundColor = [UIColor clearColor];
//        imageBackView.clipsToBounds = YES;
//        [self addSubview: imageBackView];
//        
//        // 白色背景
//        _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, imageBackView.frame.size.height - frame.size.width*179/320, frame.size.width, frame.size.width*179/320)];
////        _imageView.placeholderImage = [SOResource LessonDefaultImage];
//        _imageView.layer.anchorPoint = CGPointMake(0.5, 1);
//
//        _imageView.bottom = imageBackView.height;
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.clipsToBounds = YES;
//        [imageBackView addSubview: _imageView];
//        
//        UIView *mengBanView = [UIView viewWithFrame: _imageView.bounds
//                                         andBkColor: RGBACOLOR(0x00, 0x00, 0x00, 0.1)];
//        [_imageView addSubview: mengBanView];
//        
//        
//        // 蒙版
//        //        UIView *blackView = [UIView viewWithFrame: _imageView.bounds
//        //                                       andBkColor: RGBCOLOR_HEX(0x333333)];
//        //        blackView.backgroundColor = RGBACOLOR(0x33, 0x33, 0x33, 0.5);
//        //        [_imageView addSubview: blackView];
//        UIImageView *blackShadow = [SOResource loadImageView: @"lesson_image_shadow.png"
//                                                    andFrame: _imageView.bounds];
//        [_imageView addSubview: blackShadow];
//        
//        
//        _titleLabel = [UILabel labelWithFrame: CGRectMake(12, _imageView.height-72, 200, 16)
//                                 boldFontSize: 15
//                                    fontColor: [UIColor whiteColor]
//                                         text: @""];
//        [self addSubview: _titleLabel];
//        
//        // 描述的label
//        _descLabel = [UILabel labelWithFrame: CGRectMake(_titleLabel.left, _titleLabel.bottom+11, frame.size.width - _titleLabel.left*2, 0)
//                                boldFontSize: 13
//                                   fontColor: [UIColor whiteColor]
//                                        text: @""];
//        _descLabel.numberOfLines = 2;
//        [self addSubview: _descLabel];
        
    }
    return self;
}

@end
