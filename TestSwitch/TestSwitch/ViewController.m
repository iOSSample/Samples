//
//  ViewController.m
//  TestSwitch
//
//  Created by DuHao on 15/4/30.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ViewController.h"
#import "DSwitch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DSwitch *dswitch = [[DSwitch alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [self.view addSubview:dswitch];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
