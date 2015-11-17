//
//  GlanceController.m
//  BSKWatch WatchKit Extension
//
//  Created by DuHao on 15/4/28.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end


@implementation GlanceController
- (instancetype)init{
    self = [super init];
    
    return self;
}
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}
- (void)updateUserActivity:(NSString *)type userInfo:(NSDictionary *)userInfo webpageURL:(NSURL *)webpageURL{
    
}
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



