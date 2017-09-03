//
//  XJSongHeaderView.m
//  music
//
//  Created by kent on 2017/8/30.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJSongHeaderView.h"
#import "TracksViewModel.h"

static CGFloat gap = 20;

@implementation XJSongHeaderView
{
    void(^c_backBlock)();
    void(^c_menuBunBlock)();
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    [_bgImageView addSubview:effectview];
    [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgImageView);
    }];

    
    UIButton *backBun = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBun];
    [backBun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(gap);
        make.leading.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [backBun setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBun addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *menuBun = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:menuBun];
    [menuBun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(gap);
        make.trailing.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [menuBun setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBun addTarget:self action:@selector(menuClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBackBun:(void (^)())backBlock{
    c_backBlock = [backBlock copy];
}
- (void)clickMenuBun:(void (^)())muneBlock{
    c_menuBunBlock = [muneBlock copy];
}

- (void)backclick{
    if (c_backBlock) {
        c_backBlock();
    }
}

- (void)menuClick{
    if (c_menuBunBlock) {
        c_menuBunBlock();
    }
}


- (void)setContent:(TracksViewModel *)model{
    [self.bgImageView sd_setImageWithURL:[model mCoverLarge]
                               placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
    self.navTitle.text = [model navTitle];
    [self.mCoverLargeImageView sd_setImageWithURL:[model mCoverLarge]
                                        placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
    [self.avatarImageView sd_setImageWithURL:[model avatarPath]
                                   placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
    self.playTimesLabel.text = [model playTimes];
    self.nicknameLabel.text = [model nickname];
    self.shortIntroLabel.text = [model shortIntro];
    self.tagsLabel.text = [model tags];
}

- (UILabel *)navTitle{
    if (!_navTitle) {
        _navTitle = [[UILabel alloc]init];
        _navTitle.textColor = [UIColor whiteColor];
        _navTitle.font = [UIFont systemFontOfSize:16 weight:0.3];
        [self addSubview:_navTitle];
        [_navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(30);
        }];
    }
    return _navTitle;
}

- (UIImageView *)mCoverLargeImageView{
    if (!_mCoverLargeImageView) {
        _mCoverLargeImageView = [[UIImageView alloc]init];
        [self addSubview:_mCoverLargeImageView];
        [_mCoverLargeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self).offset(20);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _mCoverLargeImageView;
}
- (UILabel *)playTimesLabel{
    if (!_playTimesLabel) {
        _playTimesLabel = [[UILabel alloc]init];
        _playTimesLabel.textColor = [UIColor whiteColor];
        _playTimesLabel.font = [UIFont systemFontOfSize:11];
        [self.mCoverLargeImageView addSubview:_playTimesLabel];
        [_playTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mCoverLargeImageView);
            make.bottom.equalTo(self.mCoverLargeImageView).offset(-5);
        }];
    }
    return _playTimesLabel;
}

-(UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        [self addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mCoverLargeImageView);
            make.leading.equalTo(self.mCoverLargeImageView.mas_trailing).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20.0f;
    }
    return _avatarImageView;
}
- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        [self addSubview:_nicknameLabel];
        _nicknameLabel.font = [UIFont systemFontOfSize:12 weight:0.1];
        _nicknameLabel.textColor = [UIColor whiteColor];
        [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.avatarImageView.mas_trailing).offset(5);
            make.centerY.equalTo(self.avatarImageView);
        }];
    }
    return _nicknameLabel;
}
- (UILabel *)shortIntroLabel{
    if (!_shortIntroLabel) {
        _shortIntroLabel = [[UILabel alloc]init];
        [self addSubview:_shortIntroLabel];
        _shortIntroLabel.textColor = [UIColor lightTextColor];
        _shortIntroLabel.font = [UIFont systemFontOfSize:11];
        [_shortIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.avatarImageView.mas_leading);
            make.trailing.equalTo(self).offset(-20);
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(10);
        }];
    }
    return _shortIntroLabel;
}
- (UILabel *)tagsLabel{
    if(!_tagsLabel){
        _tagsLabel = [[UILabel alloc]init];
        [self addSubview:_tagsLabel];
        _tagsLabel.font = [UIFont systemFontOfSize:11];
        _tagsLabel.textColor = [UIColor whiteColor];
        [_tagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mCoverLargeImageView.mas_trailing).offset(30);
            make.trailing.equalTo(self).offset(-20);
            make.top.equalTo(self.shortIntroLabel.mas_bottom).offset(20);
        }];
    }
    return _tagsLabel;
}



@end
