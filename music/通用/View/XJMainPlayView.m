//
//  XJMainPlayView.m
//  music
//
//  Created by kent on 2017/9/1.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMainPlayView.h"
@interface XJMainPlayView()

@end

@implementation XJMainPlayView
{
    void(^c_hideBlock)();
    void(^c_moreInfoBlock)();
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.bgImageView.image = [UIImage imageNamed:@"album_album_mask"];
    self.navLab.text = @"";
    [self.moreInfo addTarget:self action:@selector(moreInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.hideBtn addTarget:self action:@selector(hideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.infoBtn addTarget:self action:@selector(infoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -Label类
- (UILabel *)navLab{
    if (!_navLab) {
        _navLab = [[UILabel alloc]init];
        _navLab.font = [UIFont systemFontOfSize:13];
        _navLab.textAlignment = NSTextAlignmentCenter;
        _navLab.textColor = [UIColor whiteColor];
        [self addSubview:_navLab];
        [_navLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.leading.equalTo(self).offset(50);
            make.trailing.equalTo(self).offset(-50);
        }];
    }
    return _navLab;
}
- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        [self addSubview:_contentLab];
        _contentLab.textColor = [UIColor whiteColor];
        _contentLab.font = [UIFont systemFontOfSize:15];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainImageView.mas_bottom).offset(30);
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.65);
        }];
    }
    return _contentLab;
}
- (UILabel *)authorLab{
    if (!_authorLab) {
        _authorLab = [[UILabel alloc]init];
        [self addSubview:_authorLab];
        _authorLab.textColor = [UIColor whiteColor];
        _authorLab.font = [UIFont systemFontOfSize:12];
        _authorLab.textAlignment = NSTextAlignmentCenter;
        [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
    }
    return _authorLab;
}

#pragma mark -button 类
#pragma mark -更多信息
- (UIButton *)moreInfo{
    if (!_moreInfo) {
        _moreInfo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_moreInfo];
        [_moreInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.centerY.equalTo(self.navLab);
        }];
        [_moreInfo setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    }
    return _moreInfo;
}
- (void)moreInfoClick:(UIButton *)sender{
    if (c_moreInfoBlock) {
        c_moreInfoBlock();
    }
}

#pragma mark -隐藏
- (UIButton *)hideBtn{
    if (!_hideBtn) {
        _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_hideBtn];
        [_hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-20);
            make.centerY.equalTo(self.navLab);
        }];
        [_hideBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    }
    return _hideBtn;
}

- (void)hideBtnClick:(UIButton *)sender{
    if (c_hideBlock) {
        c_hideBlock();
    }
}


#pragma mark -喜欢
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.top.equalTo(self.mainImageView.mas_bottom).offset(40);
        }];
        [_likeBtn setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"red_heart"] forState:UIControlStateSelected];
    }
    return _likeBtn;
}

- (void)likeBtnClick:(UIButton *)sender{
    
}

#pragma mark -单曲循环／随机／顺序
- (UIButton *)playTypeBtn{
    if (!_playTypeBtn) {
        _playTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playTypeBtn];
        [_playTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.starLab.mas_bottom).offset(40);
            make.leading.equalTo(self).offset(20);
        }];
        [_playTypeBtn setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
    }
    return _playTypeBtn;
}

#pragma mark -上一首
- (UIButton *)PreviousSongBtn{
    if (!_PreviousSongBtn) {
        _PreviousSongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_PreviousSongBtn];
        [_PreviousSongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playSongBtn);
            make.trailing.equalTo(self.playSongBtn.mas_leading).offset(-40);
        }];
        [_PreviousSongBtn setImage:[UIImage imageNamed:@"prev_song"] forState:UIControlStateNormal];
        _PreviousSongBtn.adjustsImageWhenHighlighted = NO;
    }
    return _PreviousSongBtn;
}


#pragma mark -播放音乐
- (UIButton *)playSongBtn{
    if (!_playSongBtn) {
        _playSongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playSongBtn];
        [_playSongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.playTypeBtn);
        }];
        [_playSongBtn setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateSelected];
        [_playSongBtn setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
        //点击时不要闪一下
        _playSongBtn.adjustsImageWhenHighlighted = NO;
    }
    return _playSongBtn;
}


#pragma mark -下一首
- (UIButton *)nextSongBtn{
    if (!_nextSongBtn) {
        _nextSongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextSongBtn];
        [_nextSongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playSongBtn);
            make.leading.equalTo(self.playSongBtn.mas_trailing).offset(40);
        }];
        [_nextSongBtn setImage:[UIImage imageNamed:@"next_song"] forState:UIControlStateNormal];
        _nextSongBtn.adjustsImageWhenHighlighted = NO;
    }
    return _nextSongBtn;
}


#pragma mark -更多
- (UIButton *)infoBtn{
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_infoBtn];
        [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.playTypeBtn);
            make.trailing.equalTo(self).offset(-20);
        }];
        [_infoBtn setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
        
    }
    return _infoBtn;
}
- (void)infoBtnClick:(UIButton *)sender{
    
}

#pragma mark -进度条
-(UILabel *)starLab{
    if (!_starLab) {
        _starLab = [[UILabel alloc]init];
        [self addSubview:_starLab];
        _starLab.font = [UIFont systemFontOfSize:11];
        _starLab.textColor = [UIColor whiteColor];
        [_starLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeBtn.mas_bottom).offset(15);
            make.leading.equalTo(self).offset(20);
            
        }];
        return _starLab;
    }
    return _starLab;
}

-(UILabel *)endLab{
    if (!_endLab) {
        _endLab = [[UILabel alloc]init];
        [self addSubview:_endLab];
        _endLab.font = [UIFont systemFontOfSize:11];
        _endLab.textColor = [UIColor whiteColor];
        [_endLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.starLab);
            make.trailing.equalTo(self).offset(-20);
        }];
        return _endLab;
    }
    return _endLab;
}

- (UISlider *)speedSlider{
    if (!_speedSlider) {
        _speedSlider = [[UISlider alloc]init];
        [self addSubview:_speedSlider];
        _speedSlider.tintColor = [UIColor whiteColor];
        [_speedSlider setThumbImage:[UIImage imageNamed:@"music_slider_circle"] forState:UIControlStateNormal];
        [_speedSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.starLab);
            make.leading.equalTo(self.starLab.mas_trailing).offset(10);
            make.trailing.equalTo(self.endLab.mas_leading).offset(-10);
        }];
    }
    return _speedSlider;
}

- (void)valueChange:(UISlider *)slider{
    
}


#pragma mark -背景／主图片
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.backgroundColor = [UIColor lightTextColor];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        [_bgImageView addSubview:effectview];
        [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgImageView);
        }];

    }
    return _bgImageView;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        [self addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0.2*kScreenH);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenW * 0.8, kScreenW * 0.8));
        }];
        _mainImageView.clipsToBounds = YES;
        _mainImageView.layer.cornerRadius = 8;
    }
    return _mainImageView;
}

- (void)hideBlock:(void (^)())hideBlock{
    c_hideBlock = [hideBlock copy];
}
- (void)moreInfoBlock:(void(^)())moreInfoBlock{
    c_moreInfoBlock = [moreInfoBlock copy];
}

@end
