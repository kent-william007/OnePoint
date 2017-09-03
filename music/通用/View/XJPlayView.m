//
//  XJPlayView.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPlayView.h"
#import "XJSongViewController.h"

@implementation XJPlayView
{
    void(^c_touchBlock)();
}
- (instancetype)init{
    if (self = [super init]) {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //白色缺角背景
        UIImageView *bgImage = [[UIImageView alloc]init];
        [bgImage setImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [bgView addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.trailing.top.equalTo(bgView);
            make.width.mas_equalTo(bgImage.mas_height).multipliedBy(1.31);
        }];

        //圆
        NSNumber * radius = [NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/7];
        UIImageView *loopImage = [[UIImageView alloc]init];
        [loopImage setImage:[UIImage imageNamed:@"avatar_bg"]];
        [bgView addSubview:loopImage];
        [loopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgImage).offset(10);
            make.centerY.equalTo(bgImage);
            make.width.height.equalTo(radius);
        }];
        loopImage.clipsToBounds = YES;
        loopImage.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/14;
        loopImage.layer.borderColor = [UIColor orangeColor].CGColor;
        loopImage.layer.borderWidth = 2.0f;
        self.loopImage = loopImage;
        
        //按钮
        UIButton *playBun = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBun setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        [bgView addSubview:playBun];
        [playBun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(loopImage);
            make.width.height.equalTo(radius);
        }];
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

- (void)setPlayButtonView{
    
    [self.playBun setBackgroundImage:nil forState:UIControlStateNormal];
    [self.playBun setImage:nil forState:UIControlStateNormal];
}

- (void)setPauseButtonView{
    
    [self.playBun setBackgroundImage:[UIImage imageNamed:@"avatar_bg"] forState:UIControlStateNormal];
    [self.playBun setImage:[UIImage imageNamed:@"toolbar_play_h_p"] forState:UIControlStateNormal];
}
@end
