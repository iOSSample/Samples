//
//  TimerHolder.h
//  DiabetesManagement
//
//  Created by 杜豪 on 15/4/3.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimerHolder;

@protocol TimerDelegate <NSObject>

//
// timer触发了方法
//
- (void) onTimerFired:(TimerHolder*) timerHolder;

@end
/**
 *  这个工具类是为了解决timer会强引用自己的target导致一些引用循环，通过这种方法从根本上解决了不会循环引用controller
 */
@interface TimerHolder : NSObject
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id<TimerDelegate> timerDelegate;

- (void)startTimer: (NSTimeInterval)seconds
          delegate: (id<TimerDelegate>)delegate
           repeats: (BOOL)repeats;
- (void)fire;//立刻执行
- (void)stopTimer;
@end
