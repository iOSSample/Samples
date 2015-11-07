//
//  AppDelegate+PushNotifications.m
//  SpeakOut
//
//  Created by sunny on 15-1-22.
//  Copyright (c) 2015年 51tallk. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate (PushNotifications)

//
// 成功获取到 DeviceToken
//
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSMutableString* str = [NSMutableString stringWithCapacity: deviceToken.length * 2];
    const unsigned char* bytes = (const  unsigned char*)deviceToken.bytes;
    
    for (int i = 0; i < deviceToken.length; i++) {
        [str appendFormat:@"%02x", bytes[i]];
    }
    
    DHLog(@"DeviceToken: %@", str);
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString* newMethodDeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NIDASSERT([str isEqualToString: newMethodDeviceToken]);
    
    // 1. deviceToken和iPhone Device Idenfitifier不是用一个东西
    // 2. deviceToken的获取可能不需要网络也能完成
    // 3. deviceToken的获取是一个异步的过程，如果在启动时需要依赖deviceToken, 则存在一定的风险。 可以考虑对deviceToken做一个Cache
//    [[SODeviceInfo sharedInstance] setUserPushToken: (str.length > 0) ? str : @""];
//    
//    // 发送给个推
//    [[SOGeTuiManager sharedInstance].geXinSdk registerDeviceToken:  (str.length > 0) ? str : @""];
}

//
// 获取 Device Token失败
//
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DHLogMethodName();
    
    NSString *str = [NSString stringWithFormat:@"++++ Device Token failed: %@", error];
    DHLog(@"Failed: %@", str);
    
#if TARGET_IPHONE_SIMULATOR
    // 测试机器
//    [[SODeviceInfo sharedInstance] setUserPushToken:@"0a376d21cfdf4f9c97c899d8ee80df1fbe86f9579b0237908be87ceed6ec80a7"];
#endif
    
//    [[SOGeTuiManager sharedInstance].geXinSdk registerDeviceToken: @""];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    DHLogMethodName();
    BOOL isActive = (application.applicationState == UIApplicationStateActive);
    BOOL fromBackground = !isActive;
    if (fromBackground && [userInfo[@"payload"] isNonEmpty]) {
        // 只有从后台点击过来的才会进行handle
//        [[SOGeTuiManager sharedInstance] handlePushWithInfo: userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

@end
