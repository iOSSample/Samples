//
//  ViewController.m
//  毛玻璃模糊
//
//  Created by 杜豪 on 15/10/26.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)testAction:(id)sender {
    UIButton *btn= sender;
    dispatch_queue_t serial_dispath_queue = dispatch_queue_create( "com.cn.dh", NULL);
    dispatch_async(serial_dispath_queue, ^{
        NSLog(@"耗时操作1");
        [UIView animateWithDuration:1 animations:^{
            btn.frame = CGRectMake(100, 100, 100, 100);
        }];
    });
    dispatch_async(serial_dispath_queue, ^{
        NSLog(@"耗时操作2");
        int sun = 0;
        for (int i = 0; i < 10000; i++) {
            sun = i+sun;
            NSString * srt = [NSString stringWithFormat:@"asdfghjklkjhgfdsdfghjk%d",sun];
            
        }
    });
    dispatch_async(serial_dispath_queue, ^{
        NSLog(@"耗时操作3");
        int sun = 0;
        for (int i = 0; i < 100000; i++) {
            sun = i+sun;
            NSString * srt = [NSString stringWithFormat:@"asdfghjklkjhgfdsdfghjk%d",sun];
            srt = nil;
        }
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
