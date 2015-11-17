//
//  CustomNotificationController.m
//  BSKWatch
//
//  Created by DuHao on 15/5/6.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "CustomNotificationController.h"

@interface CustomNotificationController ()

@end

@implementation CustomNotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}



- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    NSDictionary *alertDictionary = [[remoteNotification objectForKey:@"aps"] objectForKey:@"alert"];
    NSString *title = [alertDictionary objectForKey:@"title"];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



