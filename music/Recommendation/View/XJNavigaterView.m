//
//  XJNavigaterView.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJNavigaterView.h"

static CGFloat height = 40;

@implementation XJNavigaterView{
    NSArray *_titleArray;
    UIButton *_currentSelectBun;
    BOOL isShow;
}

- (instancetype)initWithTitles:(NSArray *)titleArray{
    if (self = [super initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 40)]) {
        isShow = NO;
        _titleArray = [titleArray copy];
        self.userInteractionEnabled = YES;
        [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *bun = [UIButton buttonWithType:UIButtonTypeCustom];
            bun.tag = 100 + idx;
            [bun setTitle:obj forState:UIControlStateNormal];
            [self noSelectStatus:bun];
            [bun addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bun];
        }];
    }
    return self;
}

- (void)layoutSubviews{
  
  CGFloat width = ([UIScreen mainScreen].bounds.size.width-20)/_titleArray.count;
  [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         CGFloat originX = idx * width;
         [obj mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self);
             make.leading.mas_equalTo(originX);
             make.width.mas_equalTo(width);
             make.height.mas_equalTo(height);
         }];
  }];
}

- (void)click:(UIButton *)sender{
    if (sender == _currentSelectBun) {
        return;
    }else{
        [self noSelectStatus:_currentSelectBun];
        [self selectStatus:sender];
        _currentSelectBun = sender;
    }

    if ([self.delegate respondsToSelector:@selector(navigaterViewclickIndex:)]) {
        [self.delegate navigaterViewclickIndex:(sender.tag - 100)];
    }
}

- (void)setSelecButtonIndex:(NSInteger)index{
    
    UIButton *bun = self.subviews[index];
    if (bun == _currentSelectBun) {
        return;
    }else{
        [self noSelectStatus:_currentSelectBun];
        [self selectStatus:bun];
        _currentSelectBun = bun;
    }
}

//选中状态到按钮
- (void)selectStatus:(UIButton *)selectBun{
    [selectBun setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    selectBun.titleLabel.font = [UIFont systemFontOfSize:17];
}

//未选中状态到按钮
- (void)noSelectStatus:(UIButton *)noSelectBun{
    [noSelectBun setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    noSelectBun.titleLabel.font = [UIFont systemFontOfSize:15];
}


@end
