//
//  XJRecommendSectionTItle.m
//  music
//
//  Created by kent on 2017/8/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJRecommendSectionTItle.h"
#import "UIButton+Extension.h"

@interface XJRecommendSectionTItle()
@property(nonatomic,strong)UIImageView *arrowV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *moreBtn;
@end

@implementation XJRecommendSectionTItle
- (instancetype)initWithTitle:(NSString *)title hasMore:(BOOL)more titleTag:(NSInteger)titleTag{
    if (self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.arrowV.image = [UIImage imageNamed:@"tabbar_np_play"];
        self.titleLab.text = title;
        if (more) {
            [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
            [self.moreBtn setImage:[UIImage imageNamed:@"xm_accessory"] forState:UIControlStateNormal];
            [self.moreBtn setEdgeType:imageRight];
        }
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 只能使用initWithTitle：方法来初始化", __FUNCTION__);
    }
    return self;
}

- (UIImageView *)arrowV{
    if (!_arrowV) {
        _arrowV = [[UIImageView alloc]init];
        [self addSubview:_arrowV];
        [_arrowV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
    }
    return _arrowV;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.arrowV.mas_trailing).offset(2);
            make.centerY.equalTo(self.arrowV);
        }];
        _titleLab.font = [UIFont systemFontOfSize:12];
    }
    return _titleLab;
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
    }
    return _moreBtn;
}
@end
