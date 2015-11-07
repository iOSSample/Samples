//
//  OrderClass.m
//  BluetoothTest
//
//  Created by 杜豪 on 15/10/20.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "OrderClass.h"

@implementation OrderClass

#pragma mark - 创建授权命令 的 Data
+ (NSMutableData *)makeAutorOrder:(NSString *)password autoReconnect:(BOOL)reconflag deviceCode:(NSString *)device{
    //GET AUTHRO PASSWD RECONFLAG XXXXXX(6 字节 的设备码)
    NSMutableData *valueData = [NSMutableData data];
    // Password
    if (password == nil) {
        
        uint16_t value[1] = {0};
        value[0] = 0;
        [valueData appendBytes:value length:2];
        [valueData appendBytes:value length:2];
        [valueData appendBytes:value length:2];
        
    }else{
        NSData *passwordData = [Utility getDataWithString:password];
        DHLog(@"新密码 %@",passwordData);
        [valueData appendData:passwordData];
        
        // Reconflag
        uint8_t value[1] = {0};
        value[0] = reconflag ? SANMEDITECH_RECONNECT_POSITIVE_FLAG : SANMEDITECH_RECONNECT_NAGETIVE_FLAG;//人为链接  后台重连
        [valueData appendBytes:value length:1];
        
        // Dev Addr
        NSData *deviceAddrData = [Utility getDataWithString:device];
        [valueData appendData:deviceAddrData];
    }
    return valueData;
}

+ (NSMutableData *)setDataToPeripheral:(id)data command:(uint8_t)cmd{
    NSMutableData *valueData = [NSMutableData data];
    switch (cmd) {
        case VOLTAGE_COMMAND:{
            break;
        }
        case RECORE_COMMAND:{
            break;
        }
        case NDFI_COMMAND:{
            break;
        }
        case ADFI_COMMAND:{
            break;
        }
        case AC_COMMAND:{
            break;
        }
        case AD_COMMAND:{
            break;
        }
        case MONITOR_COMMAND:{
            uint8_t monitorState = (uint8_t)[data integerValue];
            uint8_t value[1] = {0};
            value[0] = monitorState;
            [valueData appendBytes:value length:1];
            break;
        }
            // Setting 2Byte Integer Using same Method
        case CLEINTV_COMMAND:
        case CLENUM_COMMAND:
        case ADVINTV_COMMAND:{
            // Here Should Be Discusssed
            uint16_t number = (uint16_t)[data integerValue];
            uint16_t value[1] = {0};
            value[0] = number;
            [valueData appendBytes:value length:2];
            break;
        }
        case AUTHO_COMMAD:{
            break;
        }
        case PW_COMMAND:{
            NSString *password = (NSString *)data;
            NSData *pwData = [Utility getDataWithString:password];
            if (pwData.length <= 6) {
                [valueData appendData:pwData];
            }
            break;
        }
        case NAME_COMMAND:{
            NSString *name = (NSString *)data;
            NSData *nameData = [Utility getDataWithString:name];
            if (nameData.length <= 15) {
                [valueData appendData:nameData];
            }
            break;
        }
        default:
            break;
    }
    return valueData;
//    [self writeDataToPeripheral:valueData command:cmd withOPCode:SET_COMMAND];
}


@end
