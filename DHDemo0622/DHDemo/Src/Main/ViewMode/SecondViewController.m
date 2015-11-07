//
//  SecondViewController.m
//  DHDemo
//
//  Created by 杜豪 on 15/7/7.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
- (IBAction)btnAction:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btnAction:(id)sender {
    [self.tabBarController.tabBar showBadgeOnItemIndex:1];
    [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
}
@end
