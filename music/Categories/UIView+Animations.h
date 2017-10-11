//
//  UIView+Animations.h
//  music
//
//  Created by kent on 2017/9/3.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

/**点击收藏的动画*/
- (void)scaleAnimation;

/**背景图动画*/
- (void)startTransitionAnimation;

/**
 * imageView旋转动画
 * duration每圈时间
 */
- (void)startRotationAnimationDuration:(CFTimeInterval)duration;

/**移除动画*/
- (void)removeRotationAnimation;

/**暂停动画*/
- (void)pauseRotationAnimation;

/**重新启动动画*/
- (void)resumeRotationAnimation;
@end
