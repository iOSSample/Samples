//
//  OrderClass.h
//  BluetoothTest
//
//  Created by 杜豪 on 15/10/20.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderClass : NSObject
+ (NSMutableData *)makeAutorOrder:(NSString *)password autoReconnect:(BOOL)reconflag deviceCode:(NSString *)device;

+ (NSMutableData *)setDataToPeripheral:(id)data command:(uint8_t)cmd;

@end
