//
//  NSTimer+EOCBlocksSupport.m
//  timerButton
//
//  Created by kent on 2017/7/27.
//  Copyright © 2017年 kent. All rights reserved.
//

#import "NSTimer+EOCBlocksSupport.h"

@implementation NSTimer (EOCBlocksSupport)
+ (NSTimer*)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(eoc_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
//利用类方法不会持有变量的特性，避免循环引用
+ (void)eoc_blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
