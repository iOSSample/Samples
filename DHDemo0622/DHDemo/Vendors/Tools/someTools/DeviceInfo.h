//
//  DeviceInfo.h
//  DHDemo
//
//  Created by 51Talk Mac Air on 15/3/20.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject
+ (instancetype) sharedInstance;

@property (nonatomic, strong) NSString *uniqueDeviceToken;


@property (nonatomic, strong) NSString *userPushToken;

@property (nonatomic, strong) NSDate *firstInstallDate;
@property (nonatomic, strong) NSString *firstInstallVersion;

- (void)setFirstInstallWithCurrentVersion;
@end
