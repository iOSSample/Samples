//
//  ViewController.m
//  BluetoothTest
//
//  Created by 杜豪 on 15/9/8.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
/*
 *创建 中央  CBCentralManager
 */
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    CBCentralManager *_manager;
    CBPeripheral *_peripheral;
}
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *discoverBtn;
- (IBAction)discoverBtnAction:(id)sender;
- (IBAction)readAction:(id)sender;
- (IBAction)writeAction:(id)sender;
- (IBAction)startAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 开始扫描
- (IBAction)discoverBtnAction:(id)sender {
    //用来寻找一个指定的服务的peripheral。一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：
    NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:kServiceUUID],nil];
    [_manager scanForPeripheralsWithServices:uuidArray options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}

- (IBAction)readAction:(id)sender {
}

- (IBAction)writeAction:(id)sender {
    
    NSDictionary *postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [NSNumber numberWithInt:0],@"cmd",
                              @"423302315146545645",@"id_card",
                              [NSNumber numberWithLongLong:0],@"time",
                              @"大爷",@"name", nil];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:postInfo forKey:@"Some Key Value"];
    [archiver finishEncoding];
    

}

- (IBAction)startAction:(id)sender {
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}


#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"蓝牙开启状态");
        //用来寻找一个指定的服务的peripheral。一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：didDiscoverPeripheral
        [_manager scanForPeripheralsWithServices: @[[CBUUID UUIDWithString:kServiceUUID]]
                                         options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
        return;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"必须要开启蓝牙" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"蓝牙状态不可用 = %ld",(long)central.state);
    }
}

/*!
 *  @method centralManager:willRestoreState:
 *
 *  @param central      The central manager providing this information.
 *  @param dict			A dictionary containing information about <i>central</i> that was preserved by the system at the time the app was terminated.
 *
 *  @discussion			For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
 *						the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
 *						Bluetooth system.
 *
 *  @seealso            CBCentralManagerRestoredStatePeripheralsKey;
 *  @seealso            CBCentralManagerRestoredStateScanServicesKey;
 *  @seealso            CBCentralManagerRestoredStateScanOptionsKey;
 *
 */
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{
    DHLogMethodName();
    
}

/*!
 *  @method centralManager:didRetrievePeripherals:
 *
 *  @param central      The central manager providing this information.
 *  @param peripherals  A list of <code>CBPeripheral</code> objects.
 *
 *  @discussion         This method returns the result of a {@link retrievePeripherals} call, with the peripheral(s) that the central manager was
 *                      able to match to the provided UUID(s).
 *
 */
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    DHLogMethodName();
}

/*!
 *  @method centralManager:didRetrieveConnectedPeripherals:
 *
 *  @param central      The central manager providing this information.
 *  @param peripherals  A list of <code>CBPeripheral</code> objects representing all peripherals currently connected to the system.
 *
 *  @discussion         This method returns the result of a {@link retrieveConnectedPeripherals} call.
 *
 */
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    DHLogMethodName();
}


//当扫描到4.0的设备后，系统会通过回调函数告诉我们设备的信息，然后我们就可以连接相应的设备
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    //发现设备后即可连接该设备 调用完该方法后会调用代理CBCentralManagerDelegate的- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral表示连接上了设别
    //如果不能连接会调用 - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
    
    
    NSLog(@"peripheral name %@ \\ rssi = %ld", peripheral.name, (long)[RSSI integerValue]);
    NSLog(@"UUID = %@",peripheral.identifier);      //BEA12537-92B0-2770-C510-B7218233A474
    NSLog(@"链接状态 = %ld",(long)peripheral.state);
    NSLog(@"信号质量 = %@",RSSI);
    if ([peripheral.name isEqualToString:@"ICServer"]) {
        if (peripheral.state == CBPeripheralStateDisconnected) {
            [_manager stopScan];
            
            _peripheral = peripheral;
            [_manager connectPeripheral:_peripheral options:nil];
            
        }else{
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
    
    NSLog(@"链接成功 %@",peripheral.name);

    _peripheral.delegate = self;
    
    [_peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    
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
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"didDiscoverServices");
    //在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
    //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
    
    if (error){
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        NSLog(@"%@",error);
        return;
    }
    for (CBService *service in peripheral.services){
        //发现服务
        NSLog(@"发现服务 %@",service.UUID);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]){
            NSLog(@"Service found with UUID: %@", service.UUID); //查找特征
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
//            [peripheral discoverCharacteristics:nil forService:service];
            break;
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
    if (error==nil) {
        //在这个方法中我们要找到我们所需的服务的特性 然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
        //当setNotifyValue方法调用后调用代理CBPeripheralDelegate的- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        for (CBCharacteristic *characteristic in service.characteristics) {
            
            NSLog(@"服务特征 %@",characteristic.UUID);
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
                
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
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
    if (error){
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]){
        for (CBCharacteristic *characteristic in service.characteristics){
            NSLog(@"----didDiscoverCharacteristicsForService---%@",characteristic);
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]){
                [peripheral readValueForCharacteristic:characteristic];
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kWrriteCharacteristicUUID]]){
//                writeCharacteristic = characteristic;
                DHLog(@"%@",characteristic);
//            }
            
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
//当设备有数据返回时
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DHLogMethodName();
    NSLog(@"----Value---%@",characteristic.value);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]){
        Byte ACkValue[3] = {0};
        ACkValue[0] = 0xe0;
        ACkValue[1] = 0x00;
        ACkValue[2] = ACkValue[0] + ACkValue[1];
        NSData *data = [NSData dataWithBytes:&ACkValue length:sizeof(ACkValue)];
//        [_peripheral writeValue:data
//                      forCharacteristic:writeCharacteristic
//                                   type:CBCharacteristicWriteWithoutResponse];
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
//    if (error==nil) {
//        //调用下面的方法后 会调用到代理的- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//        [peripheral readValueForCharacteristic:characteristic];
//    }
    if (error){
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exits if it's not the transfer characteristic
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]] ){
        // Notification has started
        if (characteristic.isNotifying){
            NSLog(@"Notification began on %@", characteristic);
            [peripheral readValueForCharacteristic:characteristic];
        }else{ // Notification has stopped
            // so disconnect from the peripheral
            NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
            [_manager cancelPeripheralConnection:_peripheral];
        }
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



@end
