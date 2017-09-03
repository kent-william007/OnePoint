//
//  TracksViewModel.m
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "TracksViewModel.h"
#import "XJMoreNetManager.h"
#import "DestinationModel.h"

@interface TracksViewModel()
@property(nonatomic,strong)DestinationModel *model;
@property(nonatomic)NSInteger itemModel;
@end


@implementation TracksViewModel
- (instancetype)initWithAlbumId:(NSInteger)albumId title:(NSString *)title isAsc:(BOOL)asc{
    
    if (self = [super init]) {
        _albumId = albumId;
        _title = title;
        _asc = asc;
    }
    return self;
}

- (void)getDataCompletionHandle:(void (^)(NSError *))completed{
    self.dataTask = [XJMoreNetManager getTracksForAlbumId:_albumId mainTitle:_title idAsc:_asc completionHandle:^(id responseObject, NSError *error) {
        self.model = responseObject;
        completed(error);
    }];
}

- (void)getItemModelData:(void (^)(NSError * error))completed{
    self.dataTask = [XJMoreNetManager getTracksForAlbumId:_albumId mainTitle:_title idAsc:_albumId completionHandle:^(id responseObject, NSError *error) {
        self.model = responseObject;
        completed(error);
    }];
}

- (NSString *)trackTitleTitle:(NSInteger)indexPathRow{
    return self.model.tracks.list[indexPathRow].title;
}

/**导航标题*/
- (NSString *)navTitle{
    return self.model.album.title;
}

/**大头像*/
- (NSURL *)mCoverLarge{
    return [NSURL URLWithString:self.model.album.coverLarge];
}
/**播放次数*/
- (NSString *)playTimes{
    if (self.model.album.playTimes < 10000) {
        return [NSString stringWithFormat:@"%li",self.model.album.playTimes];
    }else{
        return [NSString stringWithFormat:@"%.1f万",self.model.album.playTimes/10000.0];
    }
}
/**小图标URL*/
- (NSURL *)avatarPath{
    return [NSURL URLWithString:self.model.album.avatarPath];
}

/**nickname*/
- (NSString *)nickname{
    return self.model.album.nickname;
}

/**简介*/
- (NSString *)shortIntro{
    return self.model.album.shortIntro;
}

/**标签*/
- (NSString *)tags{
    if (self.model.album.tags) {
        NSMutableString *muString = [NSMutableString string];
        NSArray *tagsArray = [self.model.album.tags componentsSeparatedByString:@","];
        [tagsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx==1) {
               * stop = YES;
            }
            [muString appendString:[NSString stringWithFormat:@"%@   ",obj]];
        }];
        return [muString copy];
    }
    return @"";
}
/**创建时间*/
- (NSString *)createAtForRow:(NSInteger)indexPathRow{
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳
    NSTimeInterval createTime = self.model.tracks.list[indexPathRow].createdAt/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];
}

/**行*/
- (NSInteger)rowNumber{
    return self.model.tracks.list.count;
}

/**行标题*/
- (NSString *)titleForRow:(NSInteger)indexPathRow{
    return self.model.tracks.list[indexPathRow].title;
}

/**行昵称*/
- (NSString *)nicknameRorRow:(NSInteger)indexPathRow{
    return self.model.tracks.list[indexPathRow].nickname;
}

/**作者*/
- (NSString *)authorRorRow:(NSInteger)indexPathRow{
    return self.model.tracks.list[indexPathRow].nickname;
}

/**时间-int*/
- (NSInteger)durationRorRow:(NSInteger)indexPathRow{
    
    return self.model.tracks.list[indexPathRow].duration;
}

/**时间-string*/
- (NSString *)durationStringRorRow:(NSInteger)indexPathRow{
    return [NSString timeIntervalToMMSSFormat:self.model.tracks.list[indexPathRow].duration];
}


/**行图标*/
- (NSURL *)coverMiddleForRow:(NSInteger)indexPathRow{
    return [NSURL URLWithString:self.model.tracks.list[indexPathRow].coverMiddle] ;
}
/**大图标*/
- (NSURL *)coverLargeForRow:(NSInteger)indexPathRow{
     return [NSURL URLWithString:self.model.tracks.list[indexPathRow].coverLarge] ;
}

/**音乐URL*/
- (NSURL *)playURLForRow:(NSInteger)indexPathRow{
    NSString *path = self.model.tracks.list[indexPathRow].playUrl64;
    return [NSURL URLWithString:path];
}

/**专辑小图标*/
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow{
    NSString *path = self.model.tracks.list[indexPathRow].coverSmall;
    return [NSURL URLWithString:path];
}
@end
