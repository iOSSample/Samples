//
//  ViewController.m
//  TestFBPOP
//
//  Created by 杜豪 on 15/10/14.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"


typedef enum {
    kSuXiao = 100,
    kShache,
    kNumber,
    kHealthSmoke,
    kHealthSleep,
    kHealthDrink
}kType;
@interface ViewController (){
    UIButton *_suxiaoBtn;
    UIButton *_shacheBtn;
    UIButton *_numberBtn;
    UILabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _suxiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 200, 100)];
    _suxiaoBtn.tag = kSuXiao;
    [_suxiaoBtn setBackgroundColor:[UIColor redColor]];
    [_suxiaoBtn addTarget:self action:@selector(onClickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_suxiaoBtn];
    
    _shacheBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 200, 100)];
    _shacheBtn.backgroundColor = [UIColor orangeColor];
    _shacheBtn.tag = kShache;
    [_shacheBtn addTarget:self action:@selector(onClickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shacheBtn];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 200, 40)];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:38];
    [self.view addSubview:_label];
    
    _numberBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 280, 200, 30)];
    _numberBtn.backgroundColor = [UIColor greenColor];
    _numberBtn.tag = kNumber;
    [_numberBtn addTarget:self action:@selector(onClickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_numberBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onClickBtnAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    if (tag == kSuXiao) {
        //    这个动效将按钮缩小到一半
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
        scaleAnimation.springBounciness = 10.f;
        [btn.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
        
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 400, 400)];
//        [btn.layer pop_addAnimation:anim forKey:@"size"];
        
//        POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//        anim.velocity = @(10.);
//        [btn.layer pop_addAnimation:anim forKey:@"slide"];
    }
    if (tag == kShache) {
        POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        anim.velocity = @(100.0);
        anim.fromValue =  @(10.0);
        //anim.deceleration = 0.998;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                NSLog(@"Stop!");
            }
        };
        [btn.layer pop_addAnimation:anim forKey:@"POPDecayAnimation"];
    }
    if (tag == kNumber) {
        POPBasicAnimation *anim = [POPBasicAnimation animation];
        anim.duration = 10.0;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        };
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];
            };
            prop.threshold = 0.01;
        }
                                        ];
        anim.property = prop;
        anim.fromValue = @(0.0); 
        anim.toValue = @(100.0);
        [_label pop_addAnimation:anim forKey:@"count"];
    }
}
@end
