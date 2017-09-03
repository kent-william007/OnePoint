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
@property(nonatomic,strong)UIImageView *loopImage;
- (void)touchPlayButton:(void(^)())clickBlock;
- (void)setPlayButtonView;
- (void)setPauseButtonView;
@end
