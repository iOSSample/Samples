//
//  ShengMeiViewController.h
//  BluetoothTest
//
//  Created by 杜豪 on 15/10/19.
//  Copyright © 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteCommandData : NSObject

@property(nonatomic,retain) id data;
@property(nonatomic, assign) OBJECT_COMMAND_STATE state;
@property (nonatomic, assign) OPERATION_COMMAND_STATE operationSate;

@end

@interface ShengMeiViewController : UIViewController

@end
