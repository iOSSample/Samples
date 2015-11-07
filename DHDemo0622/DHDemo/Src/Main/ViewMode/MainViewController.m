//
//  MainViewController.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/22.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "MainViewController.h"
#import "NetCacheManager.h"
#import "WeatherModel.h"
#import "GHIssue.h"

#import "TestModel.h"

@interface MainViewController (){
    NSString *_httpUrl;
}
- (IBAction)BtnAction:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _httpUrl = @"/apistore/weatherservice/cityid";//天气

//    NSDictionary *lastJson = [[NetCacheManager sharedInstance] loadCacheForPath:_httpUrl atUserID:@"123"];
//    if (lastJson) {
//        NSLog(@"读取本地  %@",lastJson);
//    }
    
   NSDictionary *jsonInfo = @{
        @"id": @(1),
        @"url": @"https://api.github.com/repos/octocat/Hello-World/issues/1347",
        @"html_url": @"https://github.com/octocat/Hello-World/issues/1347",
        @"number": @(1347),
        @"state": @"open",
        @"title": @"Found a bug",
        @"body": @"I'm having a problem with this.",
        @"user":@{
                @"login": @"octocat",
                @"id": @(1),
                @"avatar_url": @"https://github.com/images/error/octocat_happy.gif",
                @"gravatar_id": @"",
                @"url": @"https://api.github.com/users/octocat",
                @"html_url": @"https://github.com/octocat",
                @"followers_url": @"https://api.github.com/users/octocat/followers",
                @"type": @"User",
                @"site_admin": @(false)
                }
        };
    NSError *errpr = nil;
    GHIssue *item = nil;
    
    /*        "user": {
     "login": "octocat",
     "id": 1,
     "avatar_url": "https://github.com/images/error/octocat_happy.gif",
     "gravatar_id": "",
     "url": "https://api.github.com/users/octocat",
     "html_url": "https://github.com/octocat",
     "followers_url": "https://api.github.com/users/octocat/followers",
     "type": "User",
     "site_admin": false
     }*/
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
    [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiDuApiKey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BtnAction:(id)sender {
//    NSString *httpUrl = @"/apistore/aqiservice/aqi";
    
    

    
    [self sendGetRequest:[NSString stringWithFormat:@"%@",_httpUrl]
               parameter:@{@"cityid":@"101010100"}
                 postTag:100];
    
//    [[NetAPIClient sharedClient]
//            GET:httpUrl
//     parameters:@{@"city":@"北京"}
//        success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"成功 %@",responseObject);
//        }
//        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"失败 %@",error);
//        }];
}
- (void)callBackRequest:(NSString *)posturl Tag:(int)tag info:(NSDictionary *)info error:(NSError *)error{
    if (!error) {
        if (info) {
            NSLog(@"%@",info);
            
//            [[NetCacheManager sharedInstance] writeCacheToPath:@"/apistore/weatherservice/cityid" atUserID:@"123" jsonInfo:info];
            
//            NSError *error = nil;
//            retData *retdata = [MTLJSONAdapter modelOfClass:retData.class fromJSONDictionary:[info objectForKey:@"retData"] error:&error];
//            //[[retData alloc] initWithDictionary:[info objectForKey:@"retData"] error:&error];
//            DHLog(@"%@",retdata.weather);
//            retData *ret = [MTLJSONAdapter modelOfClass:[retData class] fromJSONDictionary:[info objectForKey:@"retData"] error:&error];
//            WeatherModel *model = [MTLJSONAdapter modelOfClass:[WeatherModel class] fromJSONDictionary:info error:&error];
//            //[[WeatherModel alloc] initWithDictionary:info error:&error];
//            if (model) {
//                DHLog(@"%@",model.errMsg);
//            }
            
            
            TestModel *testModel = [MTLJSONAdapter modelOfClass:[TestModel class] fromJSONDictionary:[info objectForKey:@"retData"] error:nil];
//            TestModel *testModel = [[TestModel alloc] initWithDictionary:[info objectForKey:@"retData"] error:nil];
            
            NSLog(@"%@",[testModel dictionaryValue]);
            
        }
    }else{
        DHLog(@"请求错误%@",error);
    }
}
@end
