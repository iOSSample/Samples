//
//  TabBarViewController.m
//  BSKWatch
//
//  Created by DuHao on 15/5/13.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "TabBarViewController.h"
#import "MyTabBarItem.h"

#define Orange [UIColor colorWithRed:255/255.0f green:130/255.0f blue:0/255.0f alpha:1]

@interface TabBarViewController (){
    NSArray *barTitleArray;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LoadRoot:@(1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)LoadRoot :(NSNumber *)selectNum{
    barTitleArray = [NSArray arrayWithObjects:@"首页",@"管血糖", nil];
    NSArray *vcArray = self.viewControllers;
    if (vcArray && vcArray.count > 0 && barTitleArray.count == vcArray.count) {
        for (int i = 0; i < vcArray.count; i++) {
            UIViewController *vc = [vcArray objectAtIndex:i];
            MyTabBarItem *barItem = [[MyTabBarItem alloc] initWithTitle:[barTitleArray objectAtIndex:i] image:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar%d1",i+1]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar%d2",i+1]]];//[[MyTabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
            [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor colorWithRed:122/255.0f green:122/255.0f blue:122/255.0f alpha:1], NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateNormal];
            [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           Orange, NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateSelected];
            vc.tabBarItem = barItem;
        }
    }
    // Do any additional setup after loading the view.
    self.selectedIndex=[selectNum intValue];
    //    self.selectedIndex=0;
    self.tabBar.tintColor=Orange;
    //    self.selectedViewController
    
    
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
