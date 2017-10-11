//
//  XJPLayManager.h
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TracksViewModel.h"

typedef NS_ENUM(NSUInteger,PlayCycleType){
    LOOP_ALL = 0,
    LOOP_SINGLE,
    LOOP_RANDOM
};

@protocol XJPlayManagerDelegate <NSObject>
@optional
-(void)progressCurrentValue:(NSTimeInterval) currentTime totalValue:(NSTimeInterval) totalTime;
-(void)musicPlaybackFinished:(NSNotification *)nofi;
@end

@interface XJPLayManager : NSObject

@property(nonatomic,strong)AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@property(nonatomic,weak)id<XJPlayManagerDelegate> delegate;
@property(nonatomic,assign)PlayCycleType playType;

+ (instancetype)sharedInstance;

/**添加监听播放音乐的通知*/
- (void)addPlayObserver;
/**暂停当前的音乐*/
- (void)pauseCurrentMusic;
/**暂停／播放*/
- (void)pauseMusic;
/**上一首*/
- (void)preSong;
/**下一首*/
- (void)nextSong;
/**加载音乐*/
- (void)playWithModel:(TracksViewModel *)tracks indexPathRow:(NSInteger ) indexPathRow;
/**导航*/
- (NSString *)navTitle;
/**演唱者*/
- (NSString *)playSinger;
/**歌名*/
- (NSString *)playMusicTitle;
/**封面*/
- (NSURL *)playCoverLarge;
/**音乐时长*/
- (NSTimeInterval)playDuration;
/**锁屏图片*/
- (UIImage *)lockedScreenImage;

/**收藏歌曲*/
- (void)setFavouriteSong;

/**删除收藏歌曲*/
- (void)deleFavouriteOrHistorySong;

/**歌曲是否已经被收藏*/
- (BOOL)hasFavouriteItem;

/**锁屏显示*/ 
- (void)updateLockedScreenMusic;

- (void)progress:(void(^)(NSTimeInterval currentTime,NSTimeInterval totalTime))progressValue;


@end
