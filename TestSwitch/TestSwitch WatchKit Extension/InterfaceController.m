//
//  InterfaceController.m
//  TestSwitch WatchKit Extension
//
//  Created by 杜豪 on 15/5/22.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceSlider *slider;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *label;
- (IBAction)sliderAction:(float)value;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)sliderAction:(float)value {
    [_label setText:[NSString stringWithFormat:@"%.1f",value]];
}
@end



