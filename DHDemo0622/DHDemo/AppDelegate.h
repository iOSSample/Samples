//
//  AppDelegate.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/17.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *vendor;

+ (AppDelegate*) appDelegate;

@end

// 推送相关的功能
@interface AppDelegate (PushNotifications)

@end