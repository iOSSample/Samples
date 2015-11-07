//
//  TestModel.h
//  DHDemo
//
//  Created by 杜豪 on 15/6/28.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//
#import "Mantle.h"

@interface TestModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong)NSString *WD;
@property (nonatomic ,strong)NSString *WS;
@property (nonatomic ,strong)NSString *altitude;
@property (nonatomic ,strong)NSString *city;
@property (nonatomic ,strong)NSString *citycode;
@property (nonatomic ,strong)NSString *date;
@property (nonatomic ,strong)NSString *h_tmp;
@property (nonatomic ,strong)NSString *l_tmp;
@property (nonatomic ,strong)NSString *latitude;
@property (nonatomic ,strong)NSString *longitude;
@property (nonatomic ,strong)NSString *pinyin;
@property (nonatomic ,strong)NSString *postCode;
@property (nonatomic ,strong)NSString *sunrise;
@property (nonatomic ,strong)NSString *sunset;
@property (nonatomic ,strong)NSString *temp;
@property (nonatomic ,strong)NSString *time;
@property (nonatomic ,strong)NSString *weather;

@end
