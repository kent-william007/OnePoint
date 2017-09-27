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
    transition.duration = 1.0f;
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
- (void)stopRotationAnimation{
    [self.layer removeAllAnimations];
}


@end
