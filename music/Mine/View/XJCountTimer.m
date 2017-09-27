//
//  XJCountTimer.m
//  music
//
//  Created by kent on 2017/9/25.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJCountTimer.h"
#import "NSTimer+EOCBlocksSupport.h"

static XJCountTimer *_instance;
static dispatch_once_t _onceToken;
NSUInteger _totalTime;
void (^_countDownBlock)();
void(^_displayTimeBlock)(NSString *);

@implementation XJCountTimer


+ (instancetype)shareInstance{

    dispatch_once(&_onceToken, ^{
//        _instance =(XJCountTimer *)[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        _instance = (XJCountTimer *)[NSTimer eoc_scheduledTimerWithTimeInterval:1 block:^{
            [self countDown];
        } repeats:YES];
    });
    return _instance;
}

+ (void)attempDealloc{
    
    if (_displayTimeBlock) {
        _displayTimeBlock(nil);
    }

    [_instance invalidate];
    _onceToken = 0;
    // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    _instance = nil;
}

+ (void)countDown{

    if (_totalTime-- == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"countDonwToZero" object:nil];
        
        if (_displayTimeBlock) {
            _displayTimeBlock(nil);
        }

        [self attempDealloc];
    }else{
        if (_displayTimeBlock) {
            _displayTimeBlock([NSString timeIntervalToMMSSFormat:_totalTime]);
        }
    }
        
    if (_countDownBlock) {
        _countDownBlock();
    }
    
}

+ (void)displayTime:(void (^)(NSString *))displayTimeBlock{
    _displayTimeBlock = [displayTimeBlock copy];
}

+ (void)startTimer{
    [[self shareInstance] setFireDate:[NSDate distantPast]];
}
+ (void)startTimer:(void (^)())countDownBlock totalTimer:(NSUInteger)totalTime{
    _countDownBlock = [countDownBlock copy];
    _totalTime = totalTime;
    [[self shareInstance] setFireDate:[NSDate distantPast]];
}

+ (void)stopTimer{
    _countDownBlock = nil;
    [[self shareInstance] setFireDate:[NSDate distantFuture]];
}

@end
