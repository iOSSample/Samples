//
//  DHMacros.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHMacros : NSObject
/**
 * Creates an opaque UIColor object from a byte-value color definition.
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 * Creates a UIColor object from a byte-value color definition and alpha transparency.
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGBCOLOR_HEX(hexColor) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f         \
green: (((hexColor >> 8) & 0xFF))/255.0f          \
blue: ((hexColor & 0xFF))/255.0f                 \
alpha: 1]

// 定义一个和给定v 类型相同的Weak Ref.变量
#define DH_DEFINE_SELF_BAR(v)      \
__weak typeof(v) _self = v

// 定义一个和给定v类型相同的arc strong变量，防止在self.block使用全局变量
#define DH_DEFINE_VARIABLE(v)   \
__weak typeof(v) _##v = v


// 将 NSTimer 删除
#define DH_INVALIDATE_TIMER(t)     \
[t invalidate];             \
t = nil

// 将UIView删除(从Super中移除，并且设置为 nil)
#define DH_DELETE_VIEW(v)       \
[v removeFromSuperview];    \
v = nil


/**
 * Only writes to the log when DEBUG is defined.
 *
 * This log method will always write to the log, regardless of log levels. It is used by all
 * of the other logging methods in Nimbus' debugging library.
 */
#if defined(DEBUG) || defined(NI_DEBUG)
#define DHLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DHLog(xx, ...)  ((void)0)
#endif

/**
 * Write the containing method's name to the log using NIDPRINT.
 */
#define DHLogMethodName() DHLog(@"%s", __PRETTY_FUNCTION__)

#if defined(DEBUG) || defined(NI_DEBUG)
#define NIDCONDITIONLOG(condition, xx, ...) { if ((condition)) { DHLog(xx, ##__VA_ARGS__); } \
} ((void)0)
#else
#define NIDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif


@end
