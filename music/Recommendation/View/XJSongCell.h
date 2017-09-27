//
//  XJSongCell.h
//  music
//
//  Created by kent on 2017/8/31.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TracksViewModel;
@interface XJSongCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *nicknameLabel;
@property(nonatomic,strong)UIImageView * coverMiddleImageView;
@property(nonatomic,strong)UILabel *tagsLabel;
@property(nonatomic,strong)UILabel *updateTimeLabel;
@property(nonatomic,strong)UILabel *createdAtLabel;
//- (void)setContent:(TracksViewModel *)model;
@end
