//
//  XJRecommendViewCell.h
//  music
//
//  Created by kent on 2017/8/22.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJRecommendViewCell : UITableViewCell
//热门排行榜
@property(nonatomic,strong)UIImageView *hotRankIcon;
@property(nonatomic,strong)UILabel *hotRankLabel;

//
@property(nonatomic,strong)UIImageView *coverIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *introLabel;
@property(nonatomic,strong)UILabel *playCountLabel;
@property(nonatomic,strong)UILabel *albumRankLabel;
@end
