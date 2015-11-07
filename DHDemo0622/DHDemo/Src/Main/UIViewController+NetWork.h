//
//  UIViewController+NetWork.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/24.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock) (BOOL,NSDictionary *dictionary);


@interface UIViewController (NetWork)

-(void)sendPostRequest:(NSString *)posturl parameter:(NSDictionary*)parameters postTag:(int) tag;

-(void)sendGetRequest:(NSString *)posturl parameter:(NSDictionary*)parameters postTag:(int) tag;

-(void)callBackRequest:(NSString *)posturl Tag:(int) tag info:(NSDictionary*)info error:(NSError*)error;

@end
