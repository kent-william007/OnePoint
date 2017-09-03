//
//  XJSongCell.m
//  music
//
//  Created by kent on 2017/8/31.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJSongCell.h"
#import "TracksViewModel.h"

@implementation XJSongCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (UIImageView *)coverMiddleImageView{
    if (!_coverMiddleImageView) {
        _coverMiddleImageView = [[UIImageView alloc]init];
        [self addSubview:_coverMiddleImageView];
        [_coverMiddleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        _coverMiddleImageView.clipsToBounds = YES;
        _coverMiddleImageView.layer.cornerRadius = 30;
    }
    return _coverMiddleImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.coverMiddleImageView.mas_trailing).offset(10);
            make.top.equalTo(self).offset(10);
            make.trailing.equalTo(self).offset(-60);
        }];
    }
    return _titleLabel;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        [self addSubview:_nicknameLabel];
        _nicknameLabel.font = [UIFont systemFontOfSize:12];
        _nicknameLabel.textColor = [UIColor lightGrayColor];
        [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
    }
    return _nicknameLabel;
}

- (UILabel *)createdAtLabel{
    if (!_createdAtLabel) {
        _createdAtLabel = [[UILabel alloc]init];
        [self addSubview:_createdAtLabel];
        _createdAtLabel.font = [UIFont systemFontOfSize:12];
        _createdAtLabel.textColor = [UIColor lightGrayColor];
        [_createdAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.top.equalTo(self.mas_top).offset(25);
        }];
    }
    return _createdAtLabel;
}

@end
