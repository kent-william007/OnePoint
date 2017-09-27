//
//  XJPlayView.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPlayView.h"
#import "XJSongViewController.h"

@interface XJPlayView()
@property(nonatomic,strong)UIImageView *loopImage;
@end

@implementation XJPlayView
{
    void(^c_touchBlock)();
}

+ (instancetype)shareInstance{
    static XJPlayView *playview;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playview = [[XJPlayView alloc]init];
    });
    return playview;
}
- (instancetype)init{
    if (self = [super init]) {
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        CGFloat  radius = [UIScreen mainScreen].bounds.size.width/4.5;
        //白色角背景
        UIImageView *bgImage = [[UIImageView alloc]init];
        [bgImage setImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [bgView addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView);
            make.centerY.equalTo(bgView).offset(-5);
            make.size.mas_equalTo(CGSizeMake(radius, radius));
//            make.bottom.trailing.top.equalTo(bgView);
//            make.width.mas_equalTo(bgImage.mas_height).multipliedBy(1.31);
        }];
        

        //圆
        CGFloat cradius = [UIScreen mainScreen].bounds.size.width/5;
        UIImageView *loopImage = [[UIImageView alloc]init];
        [loopImage setImage:[UIImage imageNamed:@"avatar_bg"]];
        [bgImage addSubview:loopImage];
        [loopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(loopImage.superview);
            make.size.mas_equalTo(CGSizeMake(cradius, cradius));
        }];
        loopImage.clipsToBounds = YES;
        loopImage.layer.cornerRadius = cradius/2.0;
        loopImage.layer.borderColor = [UIColor orangeColor].CGColor;
        loopImage.layer.borderWidth = 2.0f;
        _loopImage = loopImage;
        
        //按钮
        UIButton *playBun = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBun setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        [bgImage addSubview:playBun];
        [playBun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(playBun.superview);
            make.size.mas_equalTo(CGSizeMake(radius, radius));
//            make.width.height.equalTo(radius);
        }];
        
        bgView.userInteractionEnabled = YES;
        bgImage.userInteractionEnabled = YES;
        loopImage.userInteractionEnabled = YES;
        
        [playBun addTarget:self action:@selector(playbunClick:) forControlEvents:UIControlEventTouchUpInside];
        self.playBun = playBun;
    }
    return self;
}

- (void)touchPlayButton:(void (^)())clickBlock{
    c_touchBlock = [clickBlock copy];
}

- (void)playbunClick:(UIButton *)sender{
    if (c_touchBlock) {
        c_touchBlock();
    }
}

- (void)setLoopImageUrl:(NSURL *)loopImageUrl{
    [self.loopImage sd_setImageWithURL:loopImageUrl placeholderImage:[UIImage imageNamed:@"launchImage"]];
}

- (void)startLoopTransitionAnimation{
    [self.loopImage stopRotationAnimation];
    [self.loopImage startTransitionAnimation];
    [self.loopImage startRotationAnimationDuration:6.0];
}

- (void)setPlayButtonView{
    
    [self.playBun setBackgroundImage:nil forState:UIControlStateNormal];
    [self.playBun setImage:nil forState:UIControlStateNormal];
}

- (void)setPauseButtonView{
    
    [self.playBun setBackgroundImage:[UIImage imageNamed:@"avatar_bg"] forState:UIControlStateNormal];
    [self.playBun setImage:[UIImage imageNamed:@"toolbar_play_h_p"] forState:UIControlStateNormal];
}
@end
