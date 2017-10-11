//
//  XJLibraryCell.m
//  music
//
//  Created by kent on 2017/9/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJLibraryCell.h"

@interface XJLibraryCell()
@property(nonatomic,strong)UIImageView *cellImageView;
@property(nonatomic,strong)UILabel *cellTitleLabel;
@end

@implementation XJLibraryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
- (UIImageView *)cellImageView{
    if (!_cellImageView) {
        _cellImageView = [[UIImageView alloc]init];
        [self addSubview:_cellImageView];
        [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _cellImageView;
}

- (UILabel *)cellTitleLabel{
    if (!_cellTitleLabel) {
        
        //声明UIButton并指定其位置和长宽
        _cellTitleLabel = [[UILabel alloc]init];
        [self addSubview:_cellTitleLabel];
        [_cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(120*0.15);
            make.trailing.equalTo(self).offset(120*0.3);
            make.width.mas_equalTo(120);
        }];
        
        //设置背景颜色
        // button.backgroundColor = [UIColor yellowColor];
        //button上的文字
//        [titleLabel setTitle:@"剩30天"forState:UIControlStateNormal];
        //文字颜色
//        [buttonsetTitleColor:[UIColorblackColor]forState:UIControlStateNormal];
        //设置文本在button中显示的位置，这里为居中。
        _cellTitleLabel.textAlignment =NSTextAlignmentCenter;
        //文字字体大小
        _cellTitleLabel.font = [UIFont systemFontOfSize:20];
        _cellTitleLabel.textColor = [UIColor whiteColor];
        //文字旋转角度
        _cellTitleLabel.transform =CGAffineTransformMakeRotation(M_PI_4);
        //文本自适应
        _cellTitleLabel.adjustsFontSizeToFitWidth =YES;
        [_cellTitleLabel sizeToFit];
        _cellTitleLabel.backgroundColor = [UIColor lightGrayColor];
        self.clipsToBounds = YES;


        //设置button的背景图片
        
//        [titleLabel setBackgroundImage:[UIImage imageNamed:@"label"]forState:UIControlStateNormal];
        //改变button内部文字的位置(可以自己调整,调整适合自己的项目)
//        button.titleEdgeInsets =UIEdgeInsetsMake(-13,5, -5, -10);
        //将button添加到view上

    }
    return _cellTitleLabel;
}
- (void)contentForCell:(NSDictionary *)content{
    self.cellImageView.image = [UIImage imageNamed:content[@"image"]];
    self.cellTitleLabel.text = content[@"title"];
    NSLog(@"cellTitleLabel:%@",self.cellTitleLabel);
}
@end
