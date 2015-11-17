//
//  SSQViewController.m
//  CaiPiao
//
//  Created by 杜豪 on 15/2/3.
//  Copyright (c) 2015年 dh. All rights reserved.
//

#import "SSQViewController.h"
#define Zong 33

@interface SSQViewController (){
    NSString *_guolvStr;
    NSMutableArray *_guolvArray;
    NSMutableArray *_hongqiuArray;
}
@property (strong, nonatomic) IBOutlet UILabel *hongqiu;

@property (strong, nonatomic) IBOutlet UILabel *lanqiu;

@property (strong, nonatomic) IBOutlet UILabel *guolvLabel;

@property (strong, nonatomic) IBOutlet UITextField *guolvField;
- (IBAction)addGuoLvAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (IBAction)creatMoneyAction:(id)sender;
@end

@implementation SSQViewController

@synthesize activityIndicatorView;
@synthesize hongqiu;
@synthesize lanqiu;
@synthesize guolvField;
@synthesize guolvLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hongqiuArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    _guolvStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ssqgl"];
    
    if (_guolvStr) {
        guolvLabel.text = _guolvStr;
        NSArray * array = [_guolvStr componentsSeparatedByString:@","];
        _guolvArray = [NSMutableArray arrayWithArray:array];
    }
    
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

- (IBAction)creatMoneyAction:(id)sender {
    
    [activityIndicatorView startAnimating];
    long allshu = (_guolvArray == nil) ? Zong : (Zong - _guolvArray.count);
    

    NSMutableArray *temparray = [[NSMutableArray alloc] initWithCapacity:Zong];
    
    for (int i = 1 ; i <= Zong; i++) {
        [temparray addObject:[NSNumber numberWithInt:i]];
        if (_guolvArray && _guolvArray.count > 0) {
            for (int j = 0; j < _guolvArray.count; j++) {
                if (i == [_guolvArray[j] intValue]) {
                    [temparray removeObjectAtIndex:i];
                }
            }
        }
    }
    //////////////////////组建数组//////////////////////
    int iii[5];
    for (int i = 0 ; i < 5; i ++) {
        long count = [temparray count];
        int rdm = arc4random() % count;
        NSNumber * number = [temparray objectAtIndex:rdm];
        iii[i] = [number intValue];
        [_hongqiuArray addObject:number];
        [temparray removeObjectAtIndex:rdm];
    }
    temparray=nil;
    
    
    //显示数组
    NSMutableString * str = [[NSMutableString alloc] init];
    for (int x = 0; x < _hongqiuArray.count; x++) {
        NSString *s = [NSString stringWithFormat:@"%@  ",[_hongqiuArray objectAtIndex:x]];
        [str appendFormat:@"%@",s];
    }
    hongqiu.text = str;
    [activityIndicatorView stopAnimating];

}

- (IBAction)addGuoLvAction:(id)sender {
}

@end
