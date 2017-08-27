//
//  XJRecommendViewCell.m
//  music
//
//  Created by kent on 2017/8/22.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJRecommendViewCell.h"
#import "MoreContentViewModel.h"

@interface XJRecommendViewCell()

@end

static CGFloat  m_Gap = 10;
static CGSize  iconSize = {50, 50};
static CGSize  hot_iconSize = {65, 65};


@implementation XJRecommendViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UIImageView *)hotRankIcon{
    if (!_hotRankIcon) {
        _hotRankIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:_hotRankIcon];
        [_hotRankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(m_Gap);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(hot_iconSize);
        }];
    }
    return _hotRankIcon;
}

- (UILabel *)hotRankLabel{
    if (!_hotRankLabel) {
        _hotRankLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_hotRankLabel];
        [_hotRankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.hotRankIcon.mas_trailing).offset(m_Gap);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _hotRankLabel;
}


- (UIImageView *)coverIcon{
    if (!_coverIcon) {
        _coverIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:_coverIcon];
        [_coverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_coverIcon.superview).offset(m_Gap);
            make.centerY.equalTo(_coverIcon.superview);
            make.size.mas_equalTo(iconSize);
        }];
    }
    return _coverIcon;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.coverIcon.mas_trailing).offset(10);
            make.trailing.equalTo(self.contentView).offset(-50);
            make.top.equalTo(self.contentView).offset(m_Gap);
        }];
    }
    return _titleLabel;
}
-(UILabel *)introLabel{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_introLabel];
        _introLabel.font = [UIFont systemFontOfSize:10];
        [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(m_Gap);
        }];
 
    }
    return _introLabel;
}
- (UILabel *)playCountLabel{
    if (!_playCountLabel) {
        _playCountLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_playCountLabel];
        _playCountLabel.font = [UIFont systemFontOfSize:9];
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.introLabel).offset(m_Gap);
            make.top.equalTo(self.introLabel.mas_bottom).offset(m_Gap);
        }];
    }
    return _playCountLabel;
}
- (UILabel *)albumRankLabel{
    if (!_albumRankLabel) {
        _albumRankLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_albumRankLabel];
        _albumRankLabel.font = [UIFont systemFontOfSize:9];
        [_albumRankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.playCountLabel.mas_trailing).offset(m_Gap);
            make.top.equalTo(self.playCountLabel.mas_top);
        }];
    }
    return _albumRankLabel;
}
@end
