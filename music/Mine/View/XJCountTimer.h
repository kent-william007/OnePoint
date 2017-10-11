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

/**
 *  销毁单例
 */
+ (void)attempDealloc;

/**
 *  倒计时展示内容
 */
+ (void)displayTime:(void(^)(NSString *displaytime))displayTimeBlock;

/**
 *  倒计时
 *
 *  @param countDownBlock 每一秒执行的block
 *  @param totalTime      总时间
 */
+ (void)startTimer:(void(^)())countDownBlock totalTimer:(NSUInteger)totalTime;

/**
 *  停止倒计时
 */
+ (void)stopTimer;
@end
