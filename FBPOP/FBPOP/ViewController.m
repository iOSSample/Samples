//
//  ViewController.m
//  FBPOP
//
//  Created by DuHao on 15/5/6.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnOne;
- (IBAction)btnOneAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOneAction:(id)sender {
//    这个动效将按钮缩小到一半
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    
    scaleAnimation.springBounciness = 10.f;
    
    [self.btnOne.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
}
@end
