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
@end
