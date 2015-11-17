//
//  ViewController.m
//  BSKWatch
//
//  Created by DuHao on 15/4/28.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ViewController.h"
#import "MyTabBarItem.h"

@interface ViewController ()

- (IBAction)btnAction:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
//    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
//    NSData *data = [NSData dataWithContentsOfFile:contentPath];
//    NSString *str = [[NSString alloc] initWithData:data
//                                  encoding:NSASCIIStringEncoding];
//    NSLog(@"%@",str);
    MyTabBarItem *item = (MyTabBarItem *)self.navigationController.tabBarItem;
    [item setBadgeStr:@"1"];
}
@end
