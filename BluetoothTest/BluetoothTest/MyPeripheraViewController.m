//
//  MyPeripheraViewController.m
//  BluetoothTest
//
//  Created by 杜豪 on 15/9/8.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "MyPeripheraViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
//6D4A2C1E-5D12-D8B8-0D87-F4F2F1F2B6C7      手表
//a1dc19e2-17a4-0797-9362-68a0dd4bfb6f

@interface MyPeripheraViewController ()<CBPeripheralManagerDelegate>{

}
@property(strong,nonatomic) CBPeripheralManager *peripheraManager;

@property(strong,nonatomic) CBMutableCharacteristic *customerCharacteristic;

@property (strong,nonatomic) CBMutableService *customerService;


- (IBAction)startServre:(id)sender;

@end

@implementation MyPeripheraViewController
@synthesize peripheraManager;
@synthesize customerCharacteristic;
@synthesize customerService;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startServre:(id)sender {
    //初始化后会直接调用代理的  - (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
    peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}
-(void)setupService{
    //特征
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    customerCharacteristic = [[CBMutableCharacteristic alloc]initWithType:characteristicUUID properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    //服务
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    customerService = [[CBMutableService alloc]initWithType:serviceUUID primary:YES];
    
    [customerService setCharacteristics:@[customerCharacteristic]];

    [peripheraManager addService:customerService];
    /*当调用了CBPeripheralManager的addService方法后，这里就会响应CBPeripheralManagerDelegate的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error方法。这个时候就可以开始广播我们刚刚创建的服务了。*/
}
//添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    DHLogMethodName();
    /*
     CBPeripheralManagerStateUnknown = 0,
     CBPeripheralManagerStateResetting,  //正在重置状态
     CBPeripheralManagerStateUnsupported,  //设备不支持的状态
     CBPeripheralManagerStateUnauthorized,  // 设备未授权状态
     CBPeripheralManagerStatePoweredOff,   //设备关闭状态
     CBPeripheralManagerStatePoweredOn,
     */
//    NSLog(@"状态 = %ld",(long)peripheral.state);
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"是否正在广播数据 %d",peripheral.isAdvertising);
//        [self setUp];
        [self setupService];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"必须要开启蓝牙" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"蓝牙状态不可用 = %ld",peripheral.state);
    }
}



/*!
 *  @method peripheralManager:willRestoreState:
 *
 *  @param peripheral	The peripheral manager providing this information.
 *  @param dict			A dictionary containing information about <i>peripheral</i> that was preserved by the system at the time the app was terminated.
 *
 *  @discussion			For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
 *						the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
 *						Bluetooth system.
 *
 *  @seealso            CBPeripheralManagerRestoredStateServicesKey;
 *  @seealso            CBPeripheralManagerRestoredStateAdvertisementDataKey;
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary *)dict{
    DHLogMethodName();

}

/*!
 *  @method peripheralManagerDidStartAdvertising:error:
 *
 *  @param peripheral   The peripheral manager providing this information.
 *  @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion         This method returns the result of a @link startAdvertising: @/link call. If advertisement could
 *                      not be started, the cause will be detailed in the <i>error</i> parameter.
 *
 */
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    DHLogMethodName();
    NSLog(@"in peripheralManagerDidStartAdvertisiong:error");

}

/*!
 *  @method peripheralManager:didAddService:error:
 *
 *  @param peripheral   The peripheral manager providing this information.
 *  @param service      The service that was added to the local database.
 *  @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion         This method returns the result of an @link addService: @/link call. If the service could
 *                      not be published to the local database, the cause will be detailed in the <i>error</i> parameter.
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    DHLogMethodName();
    if (error == nil) {
        //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
        //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
        NSDictionary *sendInfo = @{CBAdvertisementDataLocalNameKey : @"ICServer", CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:kServiceUUID]]};
        
        [peripheraManager startAdvertising:sendInfo];

    }

}

/*!
 *  @method peripheralManager:central:didSubscribeToCharacteristic:
 *
 *  @param peripheral       The peripheral manager providing this update.
 *  @param central          The central that issued the command.
 *  @param characteristic   The characteristic on which notifications or indications were enabled.
 *
 *  @discussion             This method is invoked when a central configures <i>characteristic</i> to notify or indicate.
 *                          It should be used as a cue to start sending updates as the characteristic value changes.
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    DHLogMethodName();

}

/*!
 *  @method peripheralManager:central:didUnsubscribeFromCharacteristic:
 *
 *  @param peripheral       The peripheral manager providing this update.
 *  @param central          The central that issued the command.
 *  @param characteristic   The characteristic on which notifications or indications were disabled.
 *
 *  @discussion             This method is invoked when a central removes notifications/indications from <i>characteristic</i>.
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    DHLogMethodName();

}

/*!
 *  @method peripheralManager:didReceiveReadRequest:
 *
 *  @param peripheral   The peripheral manager requesting this information.
 *  @param request      A <code>CBATTRequest</code> object.
 *
 *  @discussion         This method is invoked when <i>peripheral</i> receives an ATT request for a characteristic with a dynamic value.
 *                      For every invocation of this method, @link respondToRequest:withResult: @/link must be called.
 *
 *  @see                CBATTRequest
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    DHLogMethodName();
    DHLog(@"服务接收到一个 读取的请求");
}

/*!
 *  @method peripheralManager:didReceiveWriteRequests:
 *
 *  @param peripheral   The peripheral manager requesting this information.
 *  @param requests     A list of one or more <code>CBATTRequest</code> objects.
 *
 *  @discussion         This method is invoked when <i>peripheral</i> receives an ATT request or command for one or more characteristics with a dynamic value.
 *                      For every invocation of this method, @link respondToRequest:withResult: @/link should be called exactly once. If <i>requests</i> contains
 *                      multiple requests, they must be treated as an atomic unit. If the execution of one of the requests would cause a failure, the request
 *                      and error reason should be provided to <code>respondToRequest:withResult:</code> and none of the requests should be executed.
 *
 *  @see                CBATTRequest
 *
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    DHLogMethodName();
    DHLog(@"服务接收到一个 写的请求");
}

/*!
 *  @method peripheralManagerIsReadyToUpdateSubscribers:
 *
 *  @param peripheral   The peripheral manager providing this update.
 *
 *  @discussion         This method is invoked after a failed call to @link updateValue:forCharacteristic:onSubscribedCentrals: @/link, when <i>peripheral</i> is again
 *                      ready to send characteristic value updates.
 *
 */
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
    DHLogMethodName();

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
