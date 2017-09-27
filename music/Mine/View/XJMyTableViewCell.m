//
//  XJMyTableViewCell.m
//  music
//
//  Created by kent on 2017/9/6.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMyTableViewCell.h"

@implementation XJMyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
        _titleImageView.contentMode = UIViewContentModeScaleToFill;
        [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _titleImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleImageView.mas_trailing).offset(10);
            make.centerY.equalTo(self);

        }];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)mdetailLabel{
    if (!_mdetailLabel) {
        _mdetailLabel = [[UILabel alloc]init];
        [self addSubview:_mdetailLabel];
        [_mdetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
        _mdetailLabel.textColor = [UIColor lightGrayColor];
        _mdetailLabel.font = [UIFont systemFontOfSize:12];
    }
    return _mdetailLabel;
}

@end
