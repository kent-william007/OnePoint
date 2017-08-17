//
//  XJPlayView.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPlayView.h"

@implementation XJPlayView

- (instancetype)init{
    if (self = [super init]) {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *bgImage = [[UIImageView alloc]init];
        [bgImage setImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [bgView addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.trailing.top.equalTo(bgView);
            make.width.mas_equalTo(bgImage.mas_height).multipliedBy(1.31);
        }];

        NSNumber * radius = [NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/6];
        UIImageView *loopImage = [[UIImageView alloc]init];
        [loopImage setImage:[UIImage imageNamed:@"tabbar_np_loop"]];
        [bgView addSubview:loopImage];
        [loopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgImage).offset(10);
            make.centerY.equalTo(bgImage);
            make.width.height.equalTo(radius);
        }];
        
        UIButton *playBun = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBun setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        [bgView addSubview:playBun];
        [playBun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(loopImage);
            make.width.height.equalTo(radius);
        }];
        
    }
    return self;
}

@end
