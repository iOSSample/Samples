//
//  ViewController.m
//  TestMantle
//
//  Created by 杜豪 on 15/6/30.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController (){
    NSString *BaiDuAPIKey;
    NSString *httpUrl;
    NSString *httpArg;
    
}
@property (strong, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnOnClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaiDuAPIKey = @"d66c9429f2fa5bac9a08d4d7f633b39e";
    httpUrl = @"http://apis.baidu.com/apistore/weatherservice/weather";
    httpArg = @"citypinyin=beijing";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  点击按钮
- (IBAction)btnOnClick:(id)sender {
    [self request: httpUrl withHttpArg: httpArg];
}
#pragma mark -  获取网络数据
-(void)request: (NSString*)httpUrls withHttpArg: (NSString*)HttpArgs  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrls, HttpArgs];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiDuAPIKey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSDictionary *jsonObject=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableLeaves                     error:nil];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",jsonObject);
                                   if (jsonObject) {
                                       [self testModel:jsonObject];
                                   }
                               }
                           }];
}
#pragma mark -  构建model
- (void)testModel:(NSDictionary *)info{
    NSError *error = nil;
//    TestModel *testModel = [[TestModel alloc] initWithDictionary:info[@"retData"] error:&error];
    TestModel *testModel = [MTLJSONAdapter modelOfClass:TestModel.class fromJSONDictionary:[info objectForKey:@"retData"] error:&error];
    if (error) {
        NSLog(@"错误 %@",error);
    }else{
        NSLog(@"%@",[testModel dictionaryValue]);
        //将Model转化成json
        NSDictionary *jsonModel = [MTLJSONAdapter JSONDictionaryFromModel:testModel error:&error]; //将模型对象转为JSON字典
        NSLog(@"<><><><><>%@",jsonModel);
    }
}
@end
