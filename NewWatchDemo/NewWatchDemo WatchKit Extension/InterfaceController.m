//
//  InterfaceController.m
//  NewWatchDemo WatchKit Extension
//
//  Created by DuHao on 15/4/28.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"执行 -  awakeWithContext");
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"执行 - willActivate");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



