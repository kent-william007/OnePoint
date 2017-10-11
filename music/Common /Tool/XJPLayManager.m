//
//  XJPLayManager.m
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPLayManager.h"
#import "TracksViewModel.h"
#import "XJPlayView.h"
#import "XJMainPlayController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface XJPLayManager()

@property (nonatomic,strong) TracksViewModel *tracksVM;
@property (nonatomic,assign) NSInteger indexPathRow;
@property (nonatomic,assign) NSInteger rowNumber;
//@property (nonatomic,assign) NSMutableDictionary *lockedScreeninfo;

@end

BOOL _isEnterBackground;
AVPlayerItem *_mCurrentItem;

@implementation XJPLayManager{
    id  _timeObserve;
    void(^c_progressValue)(NSTimeInterval currentTime,NSTimeInterval totalTime);
    NSTimeInterval _totalTime;
    NSTimeInterval _currentTime;
}
+(instancetype)sharedInstance{
    static XJPLayManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XJPLayManager alloc]init];
        manager.playType = LOOP_ALL;
        //添加以下代码，在开启静音键时，依然能听到音乐
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    });
    return manager;
}

#pragma mark -添加播放音乐的通知
- (void)addPlayObserver{
    [[NSNotificationCenter defaultCenter]addObserver:[XJPLayManager sharedInstance] selector:@selector(playingInfoDictionary:) name:@"StartPlay" object:nil];
}

- (void)playingInfoDictionary:(NSNotification *)notification{
    XJPLayManager *playmanager = [XJPLayManager sharedInstance];
    TracksViewModel *mtracksVM = notification.userInfo[@"theSong"];
    NSInteger  mindexPathRow = [notification.userInfo[@"indexPathRow"] integerValue];
    NSURL *coverURL = notification.userInfo[@"coverURL"];
    //  [_player pauseLoopTransitionAnimation];
    //  [[XJPlayView shareInstance] pauseLoopTransitionAnimation];
    
    [[XJPlayView shareInstance] setLoopImageUrl:coverURL];
    [[XJPlayView shareInstance] setPlayButtonView];
    [[XJPlayView shareInstance] touchPlayButton:^{
        XJMainPlayController *playVC = [[XJMainPlayController alloc]init];
        playVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:YES completion:nil];
//        [self presentViewController:playVC animated:YES completion:nil];
        
    }];
    [playmanager playWithModel:mtracksVM indexPathRow:mindexPathRow];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StartPlay" object:nil];
}
- (void)pauseCurrentMusic{
    
    if (!_currentPlayerItem) {
        return;
    }
    
    [[XJPlayView shareInstance] pauseLoopTransitionAnimation];
}

#pragma mark -暂停/播放音乐
- (void)pauseMusic{
    if (!_currentPlayerItem) {
        return;
    }
    if (_player.rate) {
        [[XJPlayView shareInstance] pauseLoopTransitionAnimation];
        [_player pause];
    }else{
        [[XJPlayView shareInstance] resumeLoopTransitionAnimation];
        [_player play];
    }
}

#pragma mark -已到倒计时时间，暂停音乐
- (void)countDownpauseMusic{
    if (!_currentPlayerItem) {
        return;
    }
    if (_player.rate) {
        
        [_player pause];
    }else{
        
    }
}


#pragma mark -上一曲
- (void)preSong{
    
    switch (_playType) {
        case LOOP_ALL:
            if (_indexPathRow == 0){
                _indexPathRow = [_tracksVM rowNumber]-1;
            }else{
                _indexPathRow --;
            }
            break;
        case LOOP_SINGLE:
            
            break;
        case LOOP_RANDOM:
            _indexPathRow = random()%[_tracksVM rowNumber];
            break;
        default:
            break;
    }
    NSLog(@"第%li单曲",_indexPathRow);
    [self playWithModel:_tracksVM indexPathRow:_indexPathRow];
}

#pragma mark -下一曲
- (void)nextSong{
    
    switch (_playType) {
        case LOOP_ALL:
            if (_indexPathRow == [_tracksVM rowNumber]-1){
                _indexPathRow = 0;
            }else{
                _indexPathRow ++;
            }
            break;
        case LOOP_SINGLE:
            
            break;
        case LOOP_RANDOM:
            _indexPathRow = random()%[_tracksVM rowNumber];
            break;
        default:
            break;
    }
    NSLog(@"第%li单曲",_indexPathRow);
    [self playWithModel:_tracksVM indexPathRow:_indexPathRow];
}

- (NSString *)navTitle{
    return [_tracksVM navTitle];
}

- (NSString *)playMusicTitle{
    return  [_tracksVM titleForRow:_indexPathRow];
}

- (NSString *)playSinger{
    return [_tracksVM authorRorRow:_indexPathRow];
}

- (NSTimeInterval)playDuration{
   
    AVPlayerItem *newItem = [XJPLayManager sharedInstance].player.currentItem;
    NSTimeInterval totalTime = NSTimeIntervalSince1970;
    if (!isnan(CMTimeGetSeconds([newItem duration]) )) {
        totalTime = CMTimeGetSeconds([newItem duration]);
    }
    return totalTime;
}

- (NSURL *)playCoverLarge{
    return [_tracksVM coverLargeForRow:_indexPathRow];
}

- (UIImage *)lockedScreenImage{
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[self playCoverLarge] placeholderImage:[UIImage imageNamed:@"music_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    return [imageV.image copy];
}

-(void)playWithModel:(TracksViewModel *)tracks indexPathRow:(NSInteger)indexPathRow{
    _tracksVM = tracks;
    _rowNumber = _tracksVM.rowNumber;
    _indexPathRow = indexPathRow;
    
    NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
    [[XJPlayView shareInstance] setLoopImageUrl:[self.tracksVM coverMiddleForRow:_indexPathRow]];
    //每次点击新的曲目时，都会初始化一个新的成员变量
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    _player = [[AVPlayer alloc]initWithPlayerItem:_currentPlayerItem];
    //移除所有通知
    [self removeNotification];
    //添加通知
    [self addNotification];

    [_player play];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
//    time = playerItem.asset.duration;
    [self observeSongTime];
    
    [self setHistorySong];
}
- (void)progress:(void (^)(NSTimeInterval, NSTimeInterval))progressValue{
    c_progressValue = progressValue;
}
- (void)observeSongTime{
    
    __weak typeof(self) weakSelf = self;
    
    //监听player，美妙执行一下这个block,
    //CMTimeMake(value,timescale)意思是每秒执行多少（timcale）帧，一个周期内有多少帧（value）
    //时间间隔 = value/timcale 也就是每多少秒（时间间隔）执行一下这个block
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        NSTimeInterval currentTime =CMTimeGetSeconds([[XJPLayManager sharedInstance].player.currentItem currentTime]);
        AVPlayerItem *newItem = [XJPLayManager sharedInstance].player.currentItem;
        NSTimeInterval totalTime = NSTimeIntervalSince1970;
        if (!isnan(CMTimeGetSeconds([newItem duration]) )) {
            totalTime = CMTimeGetSeconds([newItem duration]);
        }else{
            totalTime = 0.0;
        }
#warning 使用block回调时，未解决循环引用问题
//        if (c_progressValue) {
//            c_progressValue(_currentTime,_totalTime);
//        }

        if ([weakSelf.delegate respondsToSelector:@selector(progressCurrentValue:totalValue:)]) {
            [weakSelf.delegate progressCurrentValue:currentTime totalValue:totalTime];
        }
        
        //进入后台才开始更新锁屏界面
        if (_isEnterBackground) {
            [weakSelf updateLockedScreenMusic];
        }
    }];
}

-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:)name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    //监听是否重新进入程序程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    //监听是否重新进入程序程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownpauseMusic)
                                                 name:@"countDonwToZero" object:nil];

    
    

}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [[XJPLayManager sharedInstance] nextSong];
}

- (void)setHistorySong{
    [self.tracksVM setFavouriteOrHistorySong:DataSourceHistory atIndexPatRow:_indexPathRow];
}

- (void)setFavouriteSong{
    NSLog(@"setFavouriteSong:_indexPathRow:%li",_indexPathRow);
    [self.tracksVM setFavouriteOrHistorySong:DataSourceFavorite atIndexPatRow:_indexPathRow];
}

- (void)deleFavouriteOrHistorySong{
    NSLog(@"deleFavouriteOrHistorySong:_indexPathRow:%li",_indexPathRow);
    [self.tracksVM deleFavouriteOrHistorySong:DataSourceFavorite atIndexPatRow:_indexPathRow];
}

- (BOOL)hasFavouriteItem{
    return [self.tracksVM checkFavouriteItemAtIndexPatRow:_indexPathRow];
}
- (void)applicationWillResignActive:(NSNotification *)noti{
    _isEnterBackground = YES;
}
- (void)applicationDidBecomeActive:(NSNotification *)noti{
    _isEnterBackground = NO;
}
#pragma mark - 锁屏显示
- (void)updateLockedScreenMusic{
    if (_mCurrentItem != self.player.currentItem) {
        _mCurrentItem = self.player.currentItem;
        // 播放信息中心
        MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];

        NSMutableDictionary * m_lockedScreeninfo = [NSMutableDictionary dictionary];
        // 歌手
        m_lockedScreeninfo[MPMediaItemPropertyArtist] = [self playSinger];
        // 歌曲名称
        m_lockedScreeninfo[MPMediaItemPropertyTitle] = [self playMusicTitle];
        // 设置图片
        m_lockedScreeninfo[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[self lockedScreenImage]];
        // 设置持续时间（歌曲的总时间）
        [m_lockedScreeninfo setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem duration])] forKey:MPMediaItemPropertyPlaybackDuration];
        // 设置当前播放进度
        [m_lockedScreeninfo setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem currentTime])] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        // 切换播放信息
        center.nowPlayingInfo = m_lockedScreeninfo;
    }
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
