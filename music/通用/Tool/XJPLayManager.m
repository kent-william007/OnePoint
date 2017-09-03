//
//  XJPLayManager.m
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPLayManager.h"
#import "TracksViewModel.h"

@interface XJPLayManager()

@property (nonatomic,strong) TracksViewModel *tracksVM;
@property (nonatomic,assign) NSInteger indexPathRow;
@property (nonatomic,assign) NSInteger rowNumber;
@end

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
- (void)pauseMusic{
    if (!_currentPlayerItem) {
        return;
    }
    if (_player.rate) {
        [_player pause];
    }else{
        [_player play];
    }
}

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


-(void)playWithModel:(TracksViewModel *)tracks indexPathRow:(NSInteger)indexPathRow{
    _tracksVM = tracks;
    _rowNumber = _tracksVM.rowNumber;
    _indexPathRow = indexPathRow;
    
    NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
    //每次点击新的曲目时，都会初始化一个新的成员变量
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    _player = [[AVPlayer alloc]initWithPlayerItem:_currentPlayerItem];
    //移除所有通知
    [self removeNotification];
    //添加通知
    [self addNotification];
    //监听音乐进度
    [self  observeSongTime];
    [_player play];
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
        }
#warning 使用block回调时，未解决循环引用问题
//        if (c_progressValue) {
//            c_progressValue(_currentTime,_totalTime);
//        }
        if ([weakSelf.delegate respondsToSelector:@selector(progressCurrentValue:totalValue:)]) {
            [weakSelf.delegate progressCurrentValue:currentTime totalValue:totalTime];
        }
    }];
}

-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:)name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [[XJPLayManager sharedInstance] nextSong];
}


@end
