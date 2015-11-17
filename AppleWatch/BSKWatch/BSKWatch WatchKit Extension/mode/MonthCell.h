//
//  MonthCell.h
//  BSKWatch
//
//  Created by 杜豪 on 15/5/18.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>


@interface MonthCell : NSObject
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *groupBack;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *monthLable;

@end
