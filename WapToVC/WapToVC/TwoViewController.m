//
//  TwoViewController.m
//  WapToVC
//
//  Created by 杜豪 on 15/9/9.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()<UIWebViewDelegate , WebViewJSExport>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *context;
- (IBAction)refreshAction:(id)sender;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.116/PHPGithub/PHPStudy/base/testTwo.html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"function add(a, b) { return a + b; }"];
    JSValue *add = context[@"add"];
    NSLog(@"Func: %@", add);
    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
    NSLog(@"Sum: %d",[sum toInt32]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context[@"TXBB_IOS_SDK"] = self;
}

#pragma mark - JSExport Methods
- (void)myFunction:(NSString *)name job:(NSString *)myjob{
    NSLog(@"%@ - %@",name,myjob);
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if([[url scheme] isEqualToString:@"devzeng"]) {
        //处理JavaScript和Objective-C交互
        if([[url host] isEqualToString:@"login"])
        {
            NSLog(@"%@",[url query]);
            NSLog(@"%@",url.fragment);
            //调用JS回调
            [webView stringByEvaluatingJavaScriptFromString:@"alert('登录成功!')"];
        }
        return NO;
    }
    return YES;
}

- (IBAction)refreshAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.116/PHPGithub/PHPStudy/base/testTwo.html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}
@end
