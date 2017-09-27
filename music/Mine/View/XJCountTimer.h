//
//  XJCountTimer.h
//  music
//
//  Created by kent on 2017/9/25.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XJCountTimer : NSTimer
+ (instancetype)shareInstance;
+ (void)attempDealloc;
+ (void)displayTime:(void(^)(NSString *displaytime))displayTimeBlock;
+ (void)startTimer:(void(^)())countDownBlock totalTimer:(NSUInteger)totalTime;
+ (void)stopTimer;
@end
