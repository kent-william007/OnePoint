//
//  XJSongHeaderView.h
//  music
//
//  Created by kent on 2017/8/30.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TracksViewModel;
@interface XJSongHeaderView : UIView
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *navTitle;
@property(nonatomic,strong)UIImageView *mCoverLargeImageView;
@property(nonatomic,strong)UILabel *playTimesLabel;
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UILabel *nicknameLabel;
@property(nonatomic,strong)UILabel *shortIntroLabel;
@property(nonatomic,strong)UILabel *tagsLabel;

//- (NSURL *)mCoverLarge;
//- (NSString *)playTimes;
//- (NSURL *)avatarPath;
//- (NSString *)nickname;
//- (NSString *)shortIntro;
- (void)setContent:(TracksViewModel *)model;

- (void)clickBackBun:(void(^)())backBlock;
- (void)clickMenuBun:(void(^)())muneBlock;
@end
