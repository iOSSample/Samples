//
//  FXBlurViewController.m
//  毛玻璃模糊
//
//  Created by 杜豪 on 15/10/26.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "FXBlurViewController.h"
#import "FXBlurView.h"

@interface FXBlurViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet FXBlurView *blurView;

@end

@implementation FXBlurViewController

@synthesize imageView;
@synthesize blurView;
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@",NSStringFromCGRect(imageView.frame));

    blurView.dynamic = NO;
    blurView.blurRadius = 1;
    blurView.tintColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//是否动态模糊
- (IBAction)toggleDynamic:(UISwitch *)sender
{
    blurView.dynamic = sender.on;
}

//改变模糊度
- (IBAction)updateBlur:(UISlider *)sender
{
    blurView.blurRadius = sender.value;
}

//动态变化效果
- (IBAction)toggleBlur
{
    if (blurView.blurRadius < 5){
        [UIView animateWithDuration:0.5 animations:^{
            blurView.blurRadius = 40;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            blurView.blurRadius = 0;
        }];
    }
}


@end
