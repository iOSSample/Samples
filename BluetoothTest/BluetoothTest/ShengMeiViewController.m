//
//  ShengMeiViewController.m
//  BluetoothTest
//
//  Created by 杜豪 on 15/10/19.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import "ShengMeiViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "OrderClass.h"

@implementation WriteCommandData

@end

@interface ShengMeiViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    CBCentralManager *_manager;
    CBPeripheral *_peripheral;
    CBCharacteristic *_writeCharacteristic;
    NSString *_infoText;
    BOOL blueState;
    
    NSMutableArray *writeCommandQueue;
    NSInteger objectCommandState;
    NSInteger operationCommandState;
    id writtenData;

    
}
- (IBAction)startBTAction:(id)sender;
- (IBAction)stopBTAction:(id)sender;
- (IBAction)readStateAction:(id)sender;
- (IBAction)readDataAction:(id)sender;


@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
- (IBAction)saomiaoAction:(id)sender;
- (IBAction)authorAction:(id)sender;

@end

@implementation ShengMeiViewController
@synthesize infoTextView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

    _infoText = @"";
    
    [self showMsg:@"点击开始搜索 TH-2-046"];
    
    writeCommandQueue = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//开始
- (IBAction)saomiaoAction:(id)sender {
    if (blueState) {
        [self showMsg:@"扫面链接设备"];
        //用来寻找一个指定的服务的peripheral。一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：didDiscoverPeripheral
        /*搜索周边*/
//        NSDictionary *option = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES };
        NSDictionary *option = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], CBCentralManagerScanOptionAllowDuplicatesKey,nil];
        [_manager scanForPeripheralsWithServices: nil
                                         options:option];
    }
}
//授权
- (IBAction)authorAction:(id)sender {
    // GET  AUTHRO  PASSWD  RECONFLAG (0x0 人为链接  0x03后台重连) 设备码
    //构建授权的 Data  <00000000 0000>
    [self showMsg:@"开始授权>"];
    NSMutableData *valueData = [OrderClass makeAutorOrder:nil autoReconnect:NO deviceCode:nil];
    
    [self writeDataToPeripheral:_peripheral data:valueData objectCommand:AUTHO_COMMAD OPCode:GET_COMMAND];
}
- (IBAction)startBTAction:(id)sender {
    [self showMsg:@"开始检检测"];
    NSMutableData *valueData = [OrderClass setDataToPeripheral:@(MONITOR_START) command:MONITOR_COMMAND];
    [self writeDataToPeripheral:_peripheral data:valueData objectCommand:MONITOR_COMMAND OPCode:SET_COMMAND];
    //EVENT SET
    
}

- (IBAction)stopBTAction:(id)sender {
    [self showMsg:@"停止检测"];
    NSMutableData *valueData = [OrderClass setDataToPeripheral:@(MONITOR_STOP) command:MONITOR_COMMAND];
    [self writeDataToPeripheral:_peripheral data:valueData objectCommand:MONITOR_COMMAND OPCode:SET_COMMAND];
}

- (IBAction)readStateAction:(id)sender {
    [self showMsg:@"读取全部数据"];
    [self writeDataToPeripheral:_peripheral data:nil objectCommand:AD_COMMAND OPCode:GET_COMMAND];

}

- (IBAction)readDataAction:(id)sender {
    [self showMsg:@"读取数据个数"];
    [self writeDataToPeripheral:_peripheral data:nil objectCommand:AC_COMMAND OPCode:GET_COMMAND];
// 0e 250163 00030000 00
    
    
}

- (void)writeDataToPeripheral:(CBPeripheral *)peripheral data:(id)data objectCommand:(OBJECT_COMMAND_STATE)cmd OPCode:(OPERATION_COMMAND_STATE)opCode{
    
    WriteCommandData *tempData = [[WriteCommandData alloc] init];
    tempData.data = data;
    tempData.state = cmd;
    tempData.operationSate = opCode;
    [writeCommandQueue insertObject:tempData atIndex:0];
    
    [self writeCommandInQueue:peripheral];
}

- (void)writeCommandInQueue:(CBPeripheral *)peripheral
{
    if (peripheral.state != CBPeripheralStateConnected || writeCommandQueue.count<=0)
    {
        return;
    }
    
    WriteCommandData *commandData = [writeCommandQueue objectAtIndex:0];
    
    CBCharacteristic* downCharacteristic = [self getDownLoadCharacteristicFromPeripheral:peripheral];
    
    if (downCharacteristic != nil) {
        
        uint8_t value[20] = {0};
        int count = 0;
        
        value[count++] = commandData.operationSate;
        value[count++] = commandData.state;
        
        objectCommandState = commandData.state;
        operationCommandState = commandData.operationSate;
        
        if (commandData.data) {
            writtenData = commandData.data;
            uint8_t *bytes = (uint8_t*)[commandData.data bytes];
            for (int i = 0; i < [commandData.data length]; i++) {
                value[count++] = bytes[i];
            }
        }
        
        NSData *valueData = [NSData dataWithBytes:value length:count];
        NSLog(@"---- ValueData:%@ ----",valueData);
        //<620b0000 00000000>   0X62 0X0B
        [peripheral writeValue:valueData forCharacteristic:downCharacteristic type:CBCharacteristicWriteWithoutResponse];
        
    }
    if (writeCommandQueue.count>0) {
        [writeCommandQueue removeObjectAtIndex:0];
    }
}



- (CBCharacteristic *)getDownLoadCharacteristicFromPeripheral:(CBPeripheral *)peripheral {
    
    CBCharacteristic* downCharacteristic = nil;
    for (CBService *service in peripheral.services) {
        
        uint16_t uuidValue = [self uintValueWithCBUUID:service.UUID];
        if (uuidValue == SANMEDITECH_SERVICE_UUID) {
            
            for (CBCharacteristic *characteristic in service.characteristics) {
                
                uint16_t characterUUID = [self uintValueWithCBUUID:characteristic.UUID];
                if (characterUUID==SANMEDITECH_FEATURE_CHARACTER) {
                    downCharacteristic = characteristic;
                    break;
                }
            }
            break;
        }
    }
    return downCharacteristic;
}
#pragma mark-
#pragma mark-
-(uint16_t)uintValueWithCBUUID:(CBUUID*)cbuuid
{
    uint8_t *byte = (uint8_t *)[cbuuid.data bytes];
    uint16_t result = 0;
    result = *byte;
    byte++;
    result = result<<8;
    result = result |(*byte);
    return result;
}
#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        blueState = YES;
        NSLog(@"蓝牙开启状态");
//        //用来寻找一个指定的服务的peripheral。一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：didDiscoverPeripheral
//        /*搜索周边*/
//        [_manager scanForPeripheralsWithServices: nil
//                                         options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
        return;
    }else{
        [self showMsg:@"请打开蓝牙"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"必须要开启蓝牙" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"蓝牙状态不可用 = %ld",(long)central.state);
    }
}
//当扫描到4.0的设备后，系统会通过回调函数告诉我们设备的信息，然后我们就可以连接相应的设备
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    //发现设备后即可连接该设备 调用完该方法后会调用代理CBCentralManagerDelegate的- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral表示连接上了设别
    //如果不能连接会调用 - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
    // name  TH-2-046
    // identifier DB8A9315-D797-0E7D-85B9-B949EE6C8F9C

    if ([peripheral.name isEqualToString:@"TH-2-046"]) {
        
        NSLog(@"peripheral name %@ \\ rssi = %ld", peripheral.name, (long)[RSSI integerValue]);
        NSLog(@"UUID = %@",peripheral.identifier);      //BEA12537-92B0-2770-C510-B7218233A474
        NSLog(@"链接状态 = %ld",(long)peripheral.state);
        NSLog(@"信号质量 = %@",RSSI);
        
        [self showMsg:@"搜索到 TH-2-046"];

        if (peripheral.state == CBPeripheralStateDisconnected) {
            
            [self showMsg:@"TH-2-046状态未链接 开始链接设备"];

            [_manager stopScan];
            
            _peripheral = peripheral;
            [_manager connectPeripheral:_peripheral options:nil];
            
        }else{
            [self showMsg:@"TH-2-046 设备已经链接"];
            
            NSLog(@"状态已经链接");
        }
    }
    
    //    NSString *UUID = [peripheral.identifier UUIDString];
    //    if ([[peripheral.identifier UUIDString] isEqualToString:kServiceUUID]) {
    //        NSLog(@"相等>链接");
    //        _peripheral = peripheral;
    //        [_manager connectPeripheral:_peripheral options:nil];
    //    }else{
    //        NSLog(@"不相等%@ %@",peripheral.name,peripheral.identifier);
    //    }
    
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    //此时设备已经连接上了  要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [self showMsg:[NSString stringWithFormat:@"链接成功 %@",peripheral.name]];
    
    NSLog(@"链接成功 %@",peripheral.name);
    
    _peripheral.delegate = self;
    [self showMsg:@"开始搜索服务"];
    //搜搜设备的服务
//    [_peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    [_peripheral discoverServices:nil];
    
}

/*!
 *  @method centralManager:didFailToConnectPeripheral:error:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has failed to connect.
 *  @param error        The cause of the failure.
 *
 *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has failed to complete. As connection attempts do not
 *                      timeout, the failure of a connection is atypical and usually indicative of a transient issue.
 *
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败  didFailToConnectPeripheral  %@",error);
}
//Sanmeditech
//失去和外围设备连接后重建连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"失去和外围设备连接后重建连接");
    [_manager connectPeripheral:peripheral options:nil];
}

#pragma mark -  CBPeripheralDelegate
/*!
 *  @method peripheralDidUpdateName:
 *
 *  @param peripheral	The peripheral providing this update.
 *
 *  @discussion			This method is invoked when the @link name @/link of <i>peripheral</i> changes.
 */
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral{
    DHLogMethodName();
}


/*!
 *  @method peripheral:didModifyServices:
 *
 *  @param peripheral			The peripheral providing this update.
 *  @param invalidatedServices	The services that have been invalidated
 *
 *  @discussion			This method is invoked when the @link services @/link of <i>peripheral</i> have been changed.
 *						At this point, the designated <code>CBService</code> objects have been invalidated.
 *						Services can be re-discovered via @link discoverServices: @/link.
 */

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices{
    // NS_AVAILABLE(NA, 7_0)
    DHLogMethodName();
}



/*!
 *  @method peripheral:didReadRSSI:error:
 *
 *  @param peripheral	The peripheral providing this update.
 *  @param RSSI			The current RSSI of the link.
 *  @param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link readRSSI: @/link call.
 */
//NS_AVAILABLE(NA, 8_0)
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    DHLogMethodName();
}

/*!
 *  @method peripheral:didDiscoverServices:
 *
 *  @param peripheral	The peripheral providing this information.
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverServices: @/link call. If the service(s) were read successfully, they can be retrieved via
 *						<i>peripheral</i>'s @link services @/link property.
 *
 */
//搜索到服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"didDiscoverServices");
    //在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
    //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
    [self showMsg:@"搜索到服务"];
    if (error){
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        NSLog(@"%@",error);
        return;
    }
    
    for (CBService *service in peripheral.services){
        //发现服务
        [self showMsg:[NSString stringWithFormat:@"遍历服务 %@",service.UUID]];
        DHLog(@"发现服务 %@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
        
        //下面是发现特定服务
//        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFB0"]]){
//            DHLog(@"Service found with UUID: %@", service.UUID); //查找特征
//            
////            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
//            [self showMsg:@"链接服务>特征"];
//            [peripheral discoverCharacteristics:nil forService:service];
//            break;
//        }
        
        
    }
    
}

/*!
 *  @method peripheral:didDiscoverCharacteristicsForService:error:
 *
 *  @param peripheral	The peripheral providing this information.
 *  @param service		The <code>CBService</code> object containing the characteristic(s).
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverCharacteristics:forService: @/link call. If the characteristic(s) were read successfully,
 *						they can be retrieved via <i>service</i>'s <code>characteristics</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    DHLogMethodName();
    [self showMsg:@"搜索到服务的特征"];
    if (error){
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }

    uint16_t serviceUUID = [self uintValueWithCBUUID:service.UUID];
    if (serviceUUID == SANMEDITECH_SERVICE_UUID){//FFB0
        for (CBCharacteristic *characteristic in service.characteristics){
            [self showMsg:[NSString stringWithFormat:@"遍历特征 UUID=%@ properties = %@",characteristic.UUID,@(characteristic.properties)]];
            DHLog(@"%@",characteristic);
            
            //特征 UUID 是否等于 FFB2
            uint16_t characteristicUUID = [self uintValueWithCBUUID:characteristic.UUID];
            
            if (characteristicUUID == SANMEDITECH_FEATURE_CHARACTER){//FFB2
                _writeCharacteristic = characteristic;
                [self showMsg:@"FFB2特征 setNotifyValue:YES"];
                //告知我们要监测这个服务特性的状态变化
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            if (characteristicUUID == SANMEDITECH_FACTORY_INFO_CHARACTER) {//FFB5
                [self showMsg:@"FFB5 特征 readValueForCharacteristic"];

                [peripheral readValueForCharacteristic:characteristic];
            }
            /*
             <UUID = FFB1, properties = 0x18, value = (null), notifying = NO>
             <UUID = FFB2, properties = 0x14, value = (null), notifying = NO>
             <UUID = FFB5, properties = 0x2, value = (null), notifying = NO>
             */
            
        }
    }
    
}

/*!
 *  @method peripheral:didDiscoverIncludedServicesForService:error:
 *
 *  @param peripheral	The peripheral providing this information.
 *  @param service		The <code>CBService</code> object containing the included services.
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverIncludedServices:forService: @/link call. If the included service(s) were read successfully,
 *						they can be retrieved via <i>service</i>'s <code>includedServices</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error{
    DHLogMethodName();
}
/*!
 *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link setNotifyValue:forCharacteristic: @/link call.
 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DHLogMethodName();
    [self showMsg:@"收到特征更新通知"];
    
    if (error){
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    uint16_t characteristicUUID = [self uintValueWithCBUUID:characteristic.UUID];
    
    if (characteristicUUID == SANMEDITECH_FEATURE_CHARACTER ){
        if (characteristic.isNotifying) {// Notification has started
            if (characteristic.properties==CBCharacteristicPropertyNotify) {
                NSLog(@"已订阅特征通知.");
                [self showMsg:@"已订阅特征通知."];
                return;
            }else{
                // if (characteristic.properties ==CBCharacteristicPropertyRead)
                //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                [self showMsg:@"调取从设备获取新值"];
                [peripheral readValueForCharacteristic:characteristic];
            }
            
        }else{
            NSLog(@"停止已停止.");
            [self showMsg:@"停止已停止."];
            //取消连接
            [_manager cancelPeripheralConnection:peripheral];
        }
    }
}


/*!
 *  @method peripheral:didUpdateValueForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method is invoked after a @link readValueForCharacteristic: @/link call, or upon receipt of a notification/indication.
 */
//更新特征值后（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
//当设备有数据返回时
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DHLogMethodName();
    [self showMsg:@"读-didUpdateValueForCharacteristic"];
    [self showMsg:[NSString stringWithFormat:@"返回数据 %@",characteristic.value]];
    uint16_t characteristicUUID = [self uintValueWithCBUUID:characteristic.UUID];
    NSLog(@"%hu----Value---%@",characteristicUUID,characteristic.value);

    if (characteristicUUID == SANMEDITECH_FEATURE_CHARACTER){
        if (_writeCharacteristic) {
            if (characteristic.value) {
                NSString *value=[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
                DHLog(@"读取到特征值：%@",value);
                [self showMsg:[NSString stringWithFormat:@"读取到特征值：%@",value]];
            }else{
                NSLog(@"未发现特征值.");
                [self showMsg:@"未发现特征值."];
            }
//            DHLog(@"开始授权");
//            NSData *data = [OrderClass makeAutorOrder];
//            [_peripheral writeValue:data
//                  forCharacteristic:_writeCharacteristic
//                               type:CBCharacteristicWriteWithoutResponse];
        }
        
    }
}

/*!
 *  @method peripheral:didWriteValueForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a {@link writeValue:forCharacteristic:type:} call, when the <code>CBCharacteristicWriteWithResponse</code> type is used.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DHLogMethodName();
    if (error) {
        DHLog(@"错误didWriteValueForCharacteristic %@",error);
        return;
    }
    uint16_t characteristicUUID = [self uintValueWithCBUUID:characteristic.UUID];

    if (characteristicUUID == SANMEDITECH_FEATURE_CHARACTER) {
        [self showMsg:@"didWriteValueForCharacteristic"];
        [self showMsg:[NSString stringWithFormat:@"%@",characteristic.value]];
    }
   
}



/*!
 *  @method peripheral:didDiscoverDescriptorsForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link discoverDescriptorsForCharacteristic: @/link call. If the descriptors were read successfully,
 *							they can be retrieved via <i>characteristic</i>'s <code>descriptors</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DHLogMethodName();
    
}

/*!
 *  @method peripheral:didUpdateValueForDescriptor:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param descriptor		A <code>CBDescriptor</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link readValueForDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    DHLogMethodName();
    
}

/*!
 *  @method peripheral:didWriteValueForDescriptor:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param descriptor		A <code>CBDescriptor</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link writeValue:forDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    DHLogMethodName();
    
}
- (void)showMsg:(NSString *)msg{
    _infoText = [_infoText stringByAppendingString:msg];
    _infoText = [_infoText stringByAppendingString:@"\n"];
    dispatch_async(dispatch_get_main_queue(), ^{
        infoTextView.text = _infoText;
    });
}

@end
