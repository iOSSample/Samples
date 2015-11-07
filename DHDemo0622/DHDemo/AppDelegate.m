//
//  AppDelegate.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/17.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate*) appDelegate {
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    return (AppDelegate*)delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (NSString*) vendor {
    
    static NSString* appVender = nil;
    if (appVender) {
        return appVender;
    }
    
    
    // 记录vendor信息
    // vendor.txt从哪儿来?
    // 首先: vendor.txt默认是不存在的，但是在打包时根据需要可以拷贝到Payload/SpeakOut.app目录下
    
    NSString* resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString* vendor1 = [NSString stringWithContentsOfFile: [resourcePath stringByAppendingPathComponent:@"vendor.txt"]
                                                  encoding: NSUTF8StringEncoding
                                                     error: nil];
    if ([vendor1 isNonEmpty]) {
        appVender = [vendor1 trimSpace];
        
    } else {
        appVender = @"normal";
    }
    
    return appVender;
}
@end
