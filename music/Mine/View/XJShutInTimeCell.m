//
//  XJShutInTimeCell.m
//  music
//
//  Created by kent on 2017/9/22.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJShutInTimeCell.h"
#import "NSTimer+EOCBlocksSupport.h"
#import "XJCountTimer.h"



@interface XJShutInTimeCell()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *selectImageView;
@property(nonatomic,strong)NSTimer *mTimer;

@end

@implementation XJShutInTimeCell{

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    return self;
}

- (void)selectTimer:(NSString *)timerStr{
    //选择的第一行，取消时间定时器
    if (![timerStr containsString:@"分钟"]) {
        [XJCountTimer attempDealloc];
        return;
    }

    [XJCountTimer stopTimer];

    NSLog(@"shutIn-Time-start---------");
    __block NSUInteger totalTime = [[timerStr substringToIndex:timerStr.length-2] integerValue]*60;
    [XJCountTimer startTimer:^{
        if(totalTime-- == 0){
            self.timeLab.text = @"";
        }else{
            self.timeLab.text = [NSString stringWithFormat:@"倒计时%@",[NSString timeIntervalToMMSSFormat:totalTime]];
        }
    } totalTimer:totalTime];

    
}



- (void)setSelectedRow:(BOOL)selected{
    if (selected) {
        [self.selectImageView setImage:[UIImage imageNamed:@"select"]];
        self.timeLab.hidden  = NO;
    }else{
        [self.selectImageView setImage:[UIImage imageNamed:@"unSelect"]];
        self.timeLab.hidden  = YES;
    }
}

- (void)setContent:(NSString *)contentTitle{
    self.textLabel.text = contentTitle;

}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLab];
        _timeLab.textColor = [UIColor lightGrayColor];
//        _timeLab.backgroundColor = [UIColor orangeColor];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-50);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.textAlignment = NSTextAlignmentRight;

    }
    return _timeLab;
}

-(UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_selectImageView];
        [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _selectImageView;
}

@end
