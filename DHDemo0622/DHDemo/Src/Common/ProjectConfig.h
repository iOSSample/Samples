//
//  ProjectConfig.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IN_DHDEMO

#if defined(DEBUG) || defined(ADHOC)
// 测试模式
#define API_HOST @"http://apis.baidu.com"
#else
#define API_HOST @"http://apis.baidu.com"
#endif

#define APPName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

// 苹果市场的appId
#define kSpeakOutAppId (@"959514836")

// 友盟的appId
#define kUMAppKey @"54890a1dfd98c504610003e0"

// QQ分享相关的信息
#define kQQAppId @"1104104560"
#define kQQAppKey @"yBJ3SZs1AIIv4iqA"

// 微信分享的相关信息
#define kWeixinAppId @"wx937d17ebd3b05ace"
#define kWeixinAppKey @"d7ce94761fbfa19cf626d6d18eaf26f3"

// 个推上面注册的id
#define kGeTuiAppId @"ppUSfVG1c08u1qnyQrSnp"
#define kGeTuiAppKey @"OaMj9WUvfa5HffyrqQh2O3"
#define kGeTuiAppSecret @"uK8KlD1Avg7v5Dyz1Nky07"

// 个推的相关数据
#define kGeTuiClientId                      (@"kGeTuiClientId")
#define kGeTuiLastUpdateClientIdDate        (@"kGeTuiLastUpdateClientIdDate")

// 所有参数拼起来之后后面加的一个常量串
#define kSignConstString                    (@"paramSignValue")

// 不是第一次打开app
#define kIsNotFirstInstallApp                  (@"kIsNotFirstInstallApp")


// 是否不需要统计
//#define NO_MOB_LOG

// 是否打开调试开关
//#define kInDebugMode


#pragma mark - Notifications key

// 登陆成功
#define kNotificationUserHasLoggedInSuccess (@"kNotificationUserHasLoggedInSuccess")

// 退出登录
#define kNotificationUserLoggedOut (@"kNotificationUserLoggedOut")


#define kScoreToPass (60)

// 自己录音的最大时长与元录音的倍数
#define kRecorderTimeMultiple (1.5)
#define kRecorderSilenceLevel (0.25)
#define kRecorderSilenceDuration (1.8)

//接口常量
#define BaiDuApiKey @"d66c9429f2fa5bac9a08d4d7f633b39e"



typedef enum{
    kBottomButtonNorma = 0,     //按钮未选中状态
    kBottomButtonSelected       //按钮选中状态
}kBottomButtonState;            //按钮状态


@interface ProjectConfig : NSObject

@end
