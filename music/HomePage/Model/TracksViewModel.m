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
@property(nonatomic,assign)DataSourceType sourceType;
@property(nonatomic,strong)CoreDataManager *coreManager;
@property(nonatomic,strong)NSArray<DList *> *listModelArray;
@end


@implementation TracksViewModel
/**网络加载初始化数据*/
- (instancetype)initWithAlbumId:(NSInteger)albumId title:(NSString *)title isAsc:(BOOL)asc{
    
    if (self = [super init]) {
        _albumId = albumId;
        _title = title;
        _asc = asc;
        _sourceType = DataSourceNormal;
    }
    return self;
}

/**历史／收藏初始化数据*/
- (instancetype)initWithSourceType:(DataSourceType)sourceType{
    if (self = [super init]) {
        _sourceType = sourceType;
    }
    return self;
}

- (NSArray<DList *> *)listModelArray{
    NSLog(@"%s",__func__);
    if(!_listModelArray){
        if (_sourceType == DataSourceNormal) {
            _listModelArray = self.model.tracks.list;
        }else{
            _coreManager = [[CoreDataManager alloc]init];
            _coreManager.sourceType = _sourceType;
            _listModelArray = [_coreManager getCoreData];
            //逆序数组，最后播放的拍在最前面
            _listModelArray = [[_listModelArray reverseObjectEnumerator] allObjects];
        }
    }
    return _listModelArray;
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
    NSLog(@"%s",__func__);
   return self.listModelArray[indexPathRow].title;
}

/**导航标题*/
- (NSString *)navTitle{
    return self.model.album.title;
}

/**大头像*/
- (NSURL *)mCoverLarge{
    return [NSURL URLWithString:self.model.album.coverLarge];
}

/**单曲播放次数*/
- (NSString *)playTimesForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    NSInteger c_playTimes = self.listModelArray[indexPathRow].playtimes;;
    if (c_playTimes < 10000) {
        return [NSString stringWithFormat:@"%li",c_playTimes];
    }else{
        return [NSString stringWithFormat:@"%.1f万",c_playTimes/10000.0];
    }
}
/**播放次数*/
- (NSString *)playTimes{
    NSInteger c_playTimes = self.model.album.playTimes;
    if (self.model.album.playTimes < 10000) {
        return [NSString stringWithFormat:@"%li",c_playTimes];
    }else{
        return [NSString stringWithFormat:@"%.1f万",c_playTimes/10000.0];
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
    NSLog(@"%s",__func__);
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳
    NSTimeInterval createTime = self.listModelArray[indexPathRow].createdAt/1000;
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

/** 通过行数，返回字典 */
- (DList *)trackForRow:(NSInteger)row{
    NSLog(@"总数：%li 某行%li",self.listModelArray.count,row);
    DList *track = self.listModelArray[row];
    NSLog(@"成功获取了");
    return track;
}

/**行*/
- (NSInteger)rowNumber{
    NSLog(@"%s",__func__);
    return self.listModelArray.count;
}

/**行标题*/
- (NSString *)titleForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return self.listModelArray[indexPathRow].title;
}

/**行昵称*/
- (NSString *)nicknameRorRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return self.listModelArray[indexPathRow].nickname;
}
//XJRecommendViewCell *cell = [[XJRecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJRecommendViewCell"];
//DList *model = _modelArray[indexPath.row];
//[cell.coverIcon sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"avatar_bg"]];
//cell.titleLabel.text = model.title;
//cell.introLabel.text = model.nickname;
//cell.playCountLabel.text = [NSString stringWithFormat:@"%li",model.playtimes];
//cell.albumRankLabel.text = @"";

/**作者*/
- (NSString *)authorRorRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return self.listModelArray[indexPathRow].nickname;
}

/**时间-int*/
- (NSInteger)durationRorRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return self.listModelArray[indexPathRow].duration;
}

/**时间-string*/
- (NSString *)durationStringRorRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return [NSString timeIntervalToMMSSFormat:self.listModelArray[indexPathRow].duration];
}


/**行图标*/
- (NSURL *)coverMiddleForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    return [NSURL URLWithString:self.listModelArray[indexPathRow].coverMiddle] ;
}
/**大图标*/
- (NSURL *)coverLargeForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
     return [NSURL URLWithString:self.listModelArray[indexPathRow].coverLarge] ;
}

/**音乐URL*/
- (NSURL *)playURLForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    NSString *path = self.listModelArray[indexPathRow].playUrl64;
    return [NSURL URLWithString:path];
}

/**专辑小图标*/
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow{
    NSLog(@"%s",__func__);
    NSString *path = self.listModelArray[indexPathRow].coverSmall;
    return [NSURL URLWithString:path];
}

/**历史／收藏歌曲*/
- (void)setFavouriteOrHistorySong:(DataSourceType)sourceType atIndexPatRow:(NSInteger)indexPathRow{
    DList *songContent = [self trackForRow:indexPathRow];
    if (!_coreManager) {
        _coreManager = [[CoreDataManager alloc]init];
    }
    _coreManager.sourceType = sourceType;
    NSLog(@"----->%li %@",songContent.albumId,songContent.title);
    if (songContent.title != nil) {
        [_coreManager coreDatWithDList:songContent];
    }
}
/**删除历史／收藏歌曲*/
- (void)deleFavouriteOrHistorySong:(DataSourceType)sourceType atIndexPatRow:(NSInteger)indexPathRow{
    DList *songContent = [self trackForRow:indexPathRow];
    if (!_coreManager) {
        _coreManager = [[CoreDataManager alloc]init];
    }
    _coreManager.sourceType = sourceType;
    [_coreManager deleteItem:songContent];
}

/**歌曲是否被收藏*/
- (BOOL)checkFavouriteItemAtIndexPatRow:(NSInteger)indexPathRow{
    DList *songContent = [self trackForRow:indexPathRow];
    if (!_coreManager) {
        _coreManager = [[CoreDataManager alloc]init];
    }
    _coreManager.sourceType = DataSourceFavorite;
    return [_coreManager checkItem:songContent];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
