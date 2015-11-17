//
//  recordTimeCell.h
//  BSKWatch
//
//  Created by DuHao on 15/5/14.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface recordTimeCell : NSObject
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *backGroup;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *timeTpyeLabel;

@end
