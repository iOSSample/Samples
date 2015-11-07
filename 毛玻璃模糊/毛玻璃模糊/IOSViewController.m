//
//  IOSViewController.m
//  毛玻璃模糊
//
//  Created by 杜豪 on 15/10/26.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "IOSViewController.h"

@interface IOSViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IOSViewController
@synthesize imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = imageView.bounds;
    [imageView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = 0.8f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
