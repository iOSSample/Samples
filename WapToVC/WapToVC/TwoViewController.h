//
//  TwoViewController.h
//  WapToVC
//
//  Created by 杜豪 on 15/9/9.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebViewJSExport <JSExport>

- (void)myFunction:(NSString *)name job:(NSString *)myjob;

@end

@interface TwoViewController : UIViewController

@end
