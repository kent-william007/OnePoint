//
//  XJMainPlayView.h
//  music
//
//  Created by kent on 2017/9/1.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJMainPlayView : UIView
@property(nonatomic,strong)UIButton *moreInfo;
@property(nonatomic,strong)UIButton *hideBtn;
@property(nonatomic,strong)UILabel *navLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *authorLab;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIImageView *mainImageView;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UILabel *starLab;
@property(nonatomic,strong)UILabel *endLab;
@property(nonatomic,strong)UISlider *speedSlider;
@property(nonatomic,strong)UIButton *playTypeBtn;
@property(nonatomic,strong)UIButton *PreviousSongBtn;
@property(nonatomic,strong)UIButton *playSongBtn;
@property(nonatomic,strong)UIButton *nextSongBtn;
@property(nonatomic,strong)UIButton *infoBtn;

- (void)hideBlock:(void(^)())hideBlock;
- (void)moreInfoBlock:(void(^)())moreInfoBlock;

@end
