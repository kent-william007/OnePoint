//
//  XJMainPlayController.m
//  music
//
//  Created by kent on 2017/9/1.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMainPlayController.h"
#import "XJMainPlayView.h"
#import "XJPLayManager.h"
#import "UIView+Animations.h"


@interface XJMainPlayController()<XJPlayManagerDelegate>
@property (nonatomic) NSTimeInterval total;
@property (nonatomic,strong)XJMainPlayView *mainPlayView;
@end


@implementation XJMainPlayController{
    BOOL isDrag;
}

#pragma mark -LIFE CYCLE
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
    [XJPLayManager sharedInstance].delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [XJPLayManager sharedInstance].delegate = nil;
}
#pragma mark -初始化要加载的UI
- (void)initUI{
    _mainPlayView = [[XJMainPlayView alloc]init];
    [self.view addSubview:_mainPlayView];
    [_mainPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_mainPlayView.hideBtn addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    [_mainPlayView.speedSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_mainPlayView.speedSlider addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_mainPlayView.playSongBtn addTarget:self action:@selector(playSongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainPlayView.PreviousSongBtn addTarget:self action:@selector(previousSongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainPlayView.nextSongBtn addTarget:self action:@selector(nextSongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mainPlayView.starLab.text = @"00:00";
    _mainPlayView.endLab.text =@"03:12";
    [_mainPlayView.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainPlayView.playTypeBtn addTarget:self action:@selector(playTypeClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -要更新的UI
- (void)updateUI{
    _mainPlayView.navLab.text = [[XJPLayManager sharedInstance] navTitle];
    [_mainPlayView.bgImageView sd_setImageWithURL:[[XJPLayManager sharedInstance] playCoverLarge] placeholderImage:[UIImage imageNamed:@"music_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         [_mainPlayView.bgImageView startTransitionAnimation];
    }];
    [_mainPlayView.mainImageView sd_setImageWithURL:[[XJPLayManager sharedInstance] playCoverLarge] placeholderImage:[UIImage imageNamed:@"music_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         [_mainPlayView.mainImageView startTransitionAnimation];
    }];
   
   
    _mainPlayView.contentLab.text = [[XJPLayManager sharedInstance] playMusicTitle];
    _mainPlayView.authorLab.text = [[XJPLayManager sharedInstance] playSinger];

    [_mainPlayView.speedSlider setValue:0.0 animated:YES];
#warning 使用block回调时，未解决循环引用问题
//     __weak typeof(self) weakSelf = self;
//    [[XJPLayManager sharedInstance] progress:^(NSTimeInterval currentTime, NSTimeInterval totalTime) {
//        //进度条被拖动时，由valueChange来控制starLab，endLab的显示
//        if (!isDrag) {
//            weakSelf.mainPlayView.starLab.text = [NSString timeIntervalToMMSSFormat:currentTime];
//            NSLog(@"current:%@",_mainPlayView.starLab.text);
//            weakSelf.mainPlayView.endLab.text = [NSString timeIntervalToMMSSFormat:totalTime];
//            [weakSelf.mainPlayView.speedSlider setValue:currentTime/totalTime animated:YES];
//        }
//
//    }];
    
    //预先算出currentTime和totalTime，否则等执行代理progressCurrentValue：的一秒的时间里，starLab和endLab都为空值
    NSTimeInterval currentTime =CMTimeGetSeconds([[XJPLayManager sharedInstance].player.currentItem currentTime]);
    AVPlayerItem *newItem = [XJPLayManager sharedInstance].player.currentItem;
    NSTimeInterval totalTime = NSTimeIntervalSince1970;
    if (!isnan(CMTimeGetSeconds([newItem duration]) )) {
        totalTime = CMTimeGetSeconds([newItem duration]);
    }
    self.mainPlayView.starLab.text = [NSString timeIntervalToMMSSFormat:currentTime];
    self.mainPlayView.endLab.text = [NSString timeIntervalToMMSSFormat:totalTime];
    [self.mainPlayView.speedSlider setValue:currentTime/totalTime animated:YES];
}
#pragma mark -XJPlayManagerDelegate
- (void)progressCurrentValue:(NSTimeInterval)currentTime totalValue:(NSTimeInterval)totalTime{
    //进度条被拖动时，由valueChange来控制starLab，endLab的显示
    if (!isDrag) {
        self.mainPlayView.starLab.text = [NSString timeIntervalToMMSSFormat:currentTime];
        self.mainPlayView.endLab.text = [NSString timeIntervalToMMSSFormat:totalTime];
        [self.mainPlayView.speedSlider setValue:currentTime/totalTime animated:YES];
    }
}

#pragma mark -拖动进度条
- (void)valueChange:(UISlider *)slider{
    isDrag = YES;
    NSTimeInterval dragTime = slider.value * [[XJPLayManager sharedInstance] playDuration];
    _mainPlayView.starLab.text = [NSString timeIntervalToMMSSFormat:dragTime];
}
#pragma mark -停止拖动进度条
- (void)touchUpInside:(UISlider *)slider{

    NSInteger tobeTime = floorf([[XJPLayManager sharedInstance] playDuration] * slider.value);
    [[XJPLayManager sharedInstance].player seekToTime:CMTimeMakeWithSeconds(tobeTime, 1)];
    isDrag = NO;
    if (![XJPLayManager sharedInstance].player.rate) {
       [[XJPLayManager sharedInstance].player play];
    }
}
#pragma mark -收藏按钮-点击
- (void)likeBtnClick:(UIButton *)sender{
    [sender scaleAnimation];
    sender.selected = !sender.selected;
}
#pragma mark -播放／暂停按钮-点击
- (void)playSongBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    [[XJPLayManager sharedInstance] pauseMusic];
}
#pragma mark -上一首-点击
- (void)previousSongBtnClick:(UIButton *)sender{
    [[XJPLayManager sharedInstance] preSong];
    [self updateUI];
}
#pragma mark -下一首-点击
- (void)nextSongBtnClick:(UIButton *)sender{
    [[XJPLayManager sharedInstance] nextSong];
    [self updateUI];
}
#pragma mark -顺序／单曲循环／随机播放-点击
- (void)playTypeClick:(UIButton *)sender{
    switch ([XJPLayManager sharedInstance].playType) {
        case LOOP_ALL:
            [sender setImage:[UIImage imageNamed:@"loop_single_icon"] forState:UIControlStateNormal];
            [XJPLayManager sharedInstance].playType = LOOP_SINGLE;
            [self playTypeTips:@"单曲循环"];
            break;
        case LOOP_SINGLE:
            [sender setImage:[UIImage imageNamed:@"shuffle_icon"] forState:UIControlStateNormal];
            [XJPLayManager sharedInstance].playType = LOOP_RANDOM;
            [self playTypeTips:@"随机播放"];
            break;
        case LOOP_RANDOM:
            [sender setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
            [XJPLayManager sharedInstance].playType = LOOP_ALL;
            [self playTypeTips:@"顺序循环"];
            break;
        default:
            break;
    }
}

#pragma mark -顺序／单曲循环／随机播放提示
- (void)playTypeTips:(NSString *)tips{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tips;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark -dismissViewController
- (void)dismissVC:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"XJMainPlayController-dealloc");
}





@end
