//
//  ViewController.m
//  TestBezierPath
//
//  Created by 杜豪 on 15/8/5.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"
#import "MyBezierView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MyBezierView *myview = [[MyBezierView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:myview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
