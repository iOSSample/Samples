//
//  InterfaceController.m
//  BSKWatch WatchKit Extension
//
//  Created by DuHao on 15/4/28.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "InterfaceController.h"
#import "RecordInterfaceController.h"

#define MaxProgress 45


@interface InterfaceController(){
    BOOL isPlayingAnimate;
    int type;
}
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *groupBack;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *sugerLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *lasttitleLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *unitLabel;
- (IBAction)clickChoseTimeAction;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    isPlayingAnimate = NO;
    type = 0;
    // Configure interface objects here.
    
}
//Glance 
- (void)handleUserActivity:(NSDictionary *)userInfo{
    
}
//通知notification
- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification{
    
}
- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification{
    
}
- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
//- (IBAction)recordBtnAction {
//    if (type == 0) {
//        
//        [self.groupBack setBackgroundImageNamed:@"progress+"];
//        [self.groupBack startAnimatingWithImagesInRange:NSMakeRange(0, 45) duration:3 repeatCount:1];
////        [self.groupBack startAnimating];
//        type = 1;
//    }else if(type ==1){
//        [self.groupBack setBackgroundImageNamed:@"progress-"];
//        [self.groupBack startAnimatingWithImagesInRange:NSMakeRange(0, 45) duration:3 repeatCount:1];
////        [self.groupBack startAnimating];
//        type = 2;
//    }else{
//        [self.groupBack stopAnimating];
//        type = 0;
//    }
////    if (!isPlayingAnimate) {
////        [self.groupBack setBackgroundImageNamed:@"progress-"];
////        [self.groupBack startAnimatingWithImagesInRange:NSMakeRange(0, 45) duration:3 repeatCount:0];
////        [self.groupBack startAnimating];
////        isPlayingAnimate = YES;
////    }else{
////        [self.groupBack stopAnimating];
////        isPlayingAnimate = NO;
////    }
//    
////    NSDictionary *pushInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"value",@"key", nil];
////    [self presentControllerWithName:@"RecordInterfaceController" context:pushInfo];
////    [self pushControllerWithName:@"RecordInterfaceController" context:pushInfo];
//}
- (IBAction)clickChoseTimeAction {
    NSLog(@"记血糖");
    
     NSDictionary *pushInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"value",@"key", nil];
    NSLog(@"%@",pushInfo);
//    [self presentControllerWithName:@"RecordSuger" context:pushInfo];
    [self pushControllerWithName:@"RecordSuger" context:pushInfo];
    
}


@end



