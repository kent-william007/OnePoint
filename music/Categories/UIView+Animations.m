//
//  UIView+Animations.m
//  music
//
//  Created by kent on 2017/9/3.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)
- (void)scaleAnimation{
    UIViewAnimationOptions options =  UIViewAnimationOptionCurveEaseInOut;
    [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
        [self.layer setValue:@(0.80) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            [self.layer setValue:@(1.20) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
                [self.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                
            }];

        }];

    }];
}

- (void)startTransitionAnimation {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}
- (void)startRotationAnimationDuration:(CFTimeInterval)duration{
//    UIImageView *loadImageV = [[UIImageView alloc]init];
//    loadImageV.image = [UIImage imageNamed:@"music_tuijian"];
//    loadImageV.center = self.view.center;
//    loadImageV.bounds = CGRectMake(0, 0, 50, 50);
    //动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//    rotaImageV = loadImageV;
}

- (void)removeRotationAnimation{
    [self.layer removeAllAnimations];
}

- (void)pauseRotationAnimation{
    [self pauseLayer:self.layer];
}

- (void)resumeRotationAnimation{
    [self resumeLayer:self.layer];
}

//暂停动画
-(void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//动画的恢复方法
-(void)resumeLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
