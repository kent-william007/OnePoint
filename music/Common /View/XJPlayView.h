//
//  XJPlayView.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJPlayView : UIView
@property(nonatomic,strong)UIButton *playBun;
@property(nonatomic,copy)NSURL *loopImageUrl;

+ (instancetype)shareInstance;

/**开始动画*/
- (void)startLoopTransitionAnimation;

/**暂停动画*/
- (void)pauseLoopTransitionAnimation;

/**重新启动动画*/
- (void)resumeLoopTransitionAnimation;

/**停止动画*/
- (void)stopLoopTransitionAnimation;

/**点击中间的转盘*/
- (void)touchPlayButton:(void(^)())clickBlock;

- (void)setPlayButtonView;

- (void)setPauseButtonView;
@end
