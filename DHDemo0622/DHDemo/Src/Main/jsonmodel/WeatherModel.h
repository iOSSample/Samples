//
//  WeatherModel.h
//  DHDemo
//
//  Created by 杜豪 on 15/6/23.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "BaseModel.h"
@interface retData:BaseModel
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

@interface WeatherModel : BaseModel
/* errMsg = success;
 errNum = 0;
 retData =     {
 WD = "\U65e0\U6301\U7eed\U98ce\U5411";
 WS = "\U5fae\U98ce(<10m/h)";
 altitude = 33;
 city = "\U5317\U4eac";
 citycode = 101010100;
 date = "15-06-23";
 "h_tmp" = 29;
 "l_tmp" = 22;
 latitude = "39.904";
 longitude = "116.391";
 pinyin = beijing;
 postCode = 100000;
 sunrise = "04:46";
 sunset = "19:46";
 temp = 29;
 time = "11:00";
 weather = "\U96f7\U9635\U96e8";*/
@property (nonatomic ,strong)NSString *errMsg;
@property (nonatomic )int errNum;
//@property (nonatomic,strong)NSDictionary *retData;
//@property (nonatomic ,strong)NSString *WD;
//@property (nonatomic ,strong)NSString *WS;
//@property (nonatomic ,strong)NSString *altitude;
//@property (nonatomic ,strong)NSString *city;
//@property (nonatomic ,strong)NSString *citycode;
//@property (nonatomic ,strong)NSString *date;
//@property (nonatomic ,strong)NSString *h_tmp;
//@property (nonatomic ,strong)NSString *l_tmp;
//@property (nonatomic ,strong)NSString *latitude;
//@property (nonatomic ,strong)NSString *longitude;
//@property (nonatomic ,strong)NSString *pinyin;
//@property (nonatomic ,strong)NSString *postCode;
//@property (nonatomic ,strong)NSString *sunrise;
//@property (nonatomic ,strong)NSString *sunset;
//@property (nonatomic ,strong)NSString *temp;
//@property (nonatomic ,strong)NSString *weather;

@end
