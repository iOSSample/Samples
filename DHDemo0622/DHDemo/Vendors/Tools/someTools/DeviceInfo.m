//
//  DeviceInfo.m
//  DHDemo
//
//  Created by 51Talk Mac Air on 15/3/20.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "DeviceInfo.h"
#import "SFHFKeychainUtils.h"
@implementation DeviceInfo
@synthesize userPushToken = _userPushToken;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static DeviceInfo * deviceInfo;
    dispatch_once(&onceToken, ^{
        deviceInfo = [[DeviceInfo alloc] init];
    });
    return deviceInfo;
}

- (NSString*) uniqueDeviceToken {
    
    @synchronized(self) {
        NSString* uniqueDeviceToken = [self __uniqueDeviceToken];
        
        //        NIDPRINT(@"UniqueDeviceToken: ====> %@ <====", uniqueDeviceToken);
        return uniqueDeviceToken;
    }
}

- (NSString*) __uniqueDeviceToken {
    // 150f0315421d1ea9a66259e1d015668e727ae341838175e7d2dd13a6a7664923
    static NSString* kDeviceToken = @"SO_DV_TOKEN";
    static NSString* kServiceName = @"SO_SERVICE";
    
    // 1. 首先读取新的Token
    NSString* tokenV2 = [SFHFKeychainUtils getPasswordForUsernameV2: kDeviceToken
                                                     andServiceName: kServiceName
                                                              error: nil];
    
    // 2.1. 如果读取成功，则返回:
    if ([tokenV2 isNonEmpty]) {
        return tokenV2;
    }
    
    
    // 如果处于Active状态
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        // 生成一个UUID(不是设备相关的)
        NSString* uuid = [Utility getUUID];
        uuid =  [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        [SFHFKeychainUtils storeUsername: kDeviceToken
                             andPassword: uuid
                          forServiceName: kServiceName
                          updateExisting: YES error: nil];
        
        return uuid;
    } else {
        return @"";
    }
}


- (NSString*) userPushToken {
    if (![_userPushToken isNonEmpty]) {
        _userPushToken = [Utility userDefaultObjectForKey: @"user_push_token"];
    }
    
    return _userPushToken;
}

- (void) setUserPushToken:(NSString *)userPushToken {
    if (![_userPushToken isEqualToString: userPushToken]) {
        _userPushToken = userPushToken;
        [Utility setUserDefaultObjects: @{@"user_push_token" : _userPushToken ? _userPushToken : @""}];
    }
}

- (NSDate*)firstInstallDate {
    NSString* kInstallTimeName = @"SO_FIRST_INSTALL_TIMESTAMP";
    NSString* kServiceName = @"SO_SERVICE";
    
    // 1. 首先读取新的Token
    NSString* timeStamp = [SFHFKeychainUtils getPasswordForUsernameV2: kInstallTimeName
                                                       andServiceName: kServiceName
                                                                error: nil];
    if ([timeStamp isNonEmpty]) {
        return [NSDate dateWithTimeIntervalSince1970: [timeStamp integerValue]];
    }else {
        return nil;
    }
    
}

- (NSString*)firstInstallVersion {
    NSString* kInstallVersion = @"SO_FIRST_INSTALL_VERSION";
    NSString* kServiceName = @"SO_SERVICE";
    
    // 1. 首先读取新的Token
    NSString* version = [SFHFKeychainUtils getPasswordForUsernameV2: kInstallVersion
                                                     andServiceName: kServiceName
                                                              error: nil];
    if ([version isNonEmpty]) {
        return version;
    }else {
        return nil;
    }
}

- (void)setFirstInstallWithCurrentVersion {
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *timeStampString =  [NSString stringWithFormat: @"%d", (int)[[NSDate date] timeIntervalSince1970]];
    
    NSString* kInstallTimeName = @"SO_FIRST_INSTALL_TIMESTAMP";
    NSString* kInstallVersion = @"SO_FIRST_INSTALL_VERSION";
    NSString* kServiceName = @"SO_SERVICE";
    
    NSString* version = [SFHFKeychainUtils getPasswordForUsernameV2: kInstallVersion
                                                     andServiceName: kServiceName
                                                              error: nil];
    if (![version isNonEmpty]) {
        [SFHFKeychainUtils storeUsername: kInstallTimeName
                             andPassword: timeStampString
                          forServiceName: kServiceName
                          updateExisting: YES error: nil];
        
        [SFHFKeychainUtils storeUsername: kInstallVersion
                             andPassword: currentVersion
                          forServiceName: kServiceName
                          updateExisting: YES error: nil];
    }
    
}

@end
