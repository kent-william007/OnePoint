//
//  XJMainTableViewCell.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMainTableViewCell.h"

@interface XJMainTableViewCell()
@property(nonatomic,strong)UIButton *playButton;
@end

@implementation XJMainTableViewCell{
    buttonClickBlock click_block;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.playButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)buttonClick:(UIButton *)sender{
    NSLog(@"%@",sender);
    if (click_block) {
//        click_block(self.tagInt);
    }
    if ([self.delegate respondsToSelector:@selector(mainTableViewDidClick:)]) {
        [self.delegate mainTableViewDidClick:self.tagInt];
    }
}
- (void)buttonClickBlock:(buttonClickBlock)clickBlock{
    if (clickBlock) {
        click_block = [clickBlock copy];
    }
}
- (UIImageView *)coverIV{
    if (!_coverIV) {
        _coverIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_coverIV];
        [_coverIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.contentView);
            make.bottom.mas_equalTo(-[UIScreen mainScreen].bounds.size.width * 0.2);
        }];
        
        UIView *backView = [[UIView alloc]init];
        [_coverIV addSubview:backView];
        backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_coverIV);
        }];
        _coverIV.userInteractionEnabled = YES;
    }
    return _coverIV;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.numberOfLines = 0;
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.contentView);
            make.top.mas_equalTo(self.coverIV.mas_bottom);
        }];
    }
    return _titleLb;
}
- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setHighlighted:NO];
        [_playButton setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
        [self.coverIV addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.coverIV);
        }];
    }
    return _playButton;
}


- (void)setIsPlay:(BOOL)isPlay{
    NSString *imageName= isPlay?@"big_pause_button":@"big_play_button";
    [self.playButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

































@end
