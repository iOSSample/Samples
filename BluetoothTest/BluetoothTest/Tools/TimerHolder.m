//
//  TimerHolder.m
//  DiabetesManagement
//
//  Created by 杜豪 on 15/4/3.
//  Copyright (c) 2015年 bsk. All rights reserved.
//

#import "TimerHolder.h"

@implementation TimerHolder{
    BOOL _repeats;
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startTimer: (NSTimeInterval)seconds
          delegate: (id<TimerDelegate>)delegate
           repeats: (BOOL)repeats {
    _timerDelegate = delegate;
    _repeats = repeats;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:repeats];
}
//立刻开始执行
- (void)fire{
    if (_timer) {
        [_timer fire];
    }
}
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
    _timerDelegate = nil;
}

- (void)onTimer: (NSTimer *)timer {
//    DHLogMethodName();
    if (!_repeats) {
        _timer = nil;
    }
    
    if (_timerDelegate && [_timerDelegate respondsToSelector:@selector(onTimerFired:)]) {
        [_timerDelegate onTimerFired:self];
    }
}
@end
