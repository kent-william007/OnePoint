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
- (void)contentForCell:(NSDictionary *)content{
    self.cellImageView.image = [UIImage imageNamed:content[@"image"]];
}
@end
