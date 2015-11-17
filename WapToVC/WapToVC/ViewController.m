//
//  ViewController.m
//  WapToVC
//
//  Created by 杜豪 on 15/8/6.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)refreshAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.116/PHPGithub/PHPStudy/base/testOne.html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",title);
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"%@",currentURL);


}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败 %@",error);
}


-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    NSString *urlString = url.absoluteString;
    NSLog(@"absoluteString = %@",urlString);
    NSLog(@"relativeString = %@",url.relativeString);
    NSLog(@"scheme = %@",url.scheme);
    NSLog(@"resourceSpecifier = %@",url.resourceSpecifier);
    NSLog(@"host = %@",url.host);
    NSLog(@"port = %@",url.port);
    NSLog(@"path = %@",url.path);
    NSLog(@"parameterString = %@",url.parameterString);
    NSLog(@"fragment = %@",url.fragment);
    
    NSLog(@"query = %@",url.query);
    
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked:{
            NSLog(@"点击");
            NSString *scheme = [url scheme];
            NSString *host = [url host];
            if ([scheme isEqualToString:@"goodsinfo"]){
                NSLog(@"商品详情");
                
//<a href="goodsInfo://info?goodsname=mygoodsnmae&goodsID=123456">点击测试链接</a>
               
                NSLog(@"scheme = %@",scheme);       //scheme = goodsinfo
                NSLog(@"host = %@",host);           //host = info
                NSString *goodsInfo = [url query];  //
                /* absoluteString = goodsinfo://info?goodsname=mygoodsnmae&goodsID=123456
                  relativeString = goodsinfo://info?goodsname=mygoodsnmae&goodsID=123456
                  scheme = goodsinfo
                  resourceSpecifier = //info?goodsname=mygoodsnmae&goodsID=123456
                  host = info
                  port = (null)
                  path =
                  parameterString = (null)
                  fragment = (null)
                  query = goodsname=mygoodsnmae&goodsID=123456 */
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点击商品详情" message:goodsInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                return NO;
            }else{
                return YES;
            }

        }
            break;
        case UIWebViewNavigationTypeFormSubmitted:{
            NSLog(@"提交表单");
            
        }
            break;
        case UIWebViewNavigationTypeBackForward:{
            
        }
            break;
        case UIWebViewNavigationTypeReload:{
            
        }
            break;
        case UIWebViewNavigationTypeFormResubmitted:{
            
        }
            break;
        case UIWebViewNavigationTypeOther:{
            
        }
            break;
            
        default:
            break;
    }
    return YES;
}


- (IBAction)refreshAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.116/PHPGithub/PHPStudy/base/testOne.html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
@end
