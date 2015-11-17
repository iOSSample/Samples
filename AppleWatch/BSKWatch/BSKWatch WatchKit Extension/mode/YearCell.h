//
//  YearCell.h
//  BSKWatch
//
//  Created by DuHao on 15/5/15.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface YearCell : NSObject

@property (strong, nonatomic) IBOutlet WKInterfaceGroup *groupBack;

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *yearLabel;

@end
