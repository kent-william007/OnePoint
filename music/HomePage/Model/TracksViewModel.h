//
//  TracksViewModel.h
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
/**首页Cell点击加载数据*/

#import "BaseViewModel.h"
#import "MJExtension.h"
#import "CoreDataManager.h"



@interface TracksViewModel : BaseViewModel
/**历史／收藏初始化*/
- (instancetype)initWithSourceType:(DataSourceType)sourceType;
/**把播放历史/喜欢歌曲添加到数据库*/
- (void)setFavouriteOrHistorySong:(DataSourceType) sourceType atIndexPatRow:(NSInteger)indexPathRow;
/**删除 播放历史/喜欢歌曲 */
- (void)deleFavouriteOrHistorySong:(DataSourceType) sourceType atIndexPatRow:(NSInteger)indexPathRow;

/**歌曲是否被收藏*/
- (BOOL)checkFavouriteItemAtIndexPatRow:(NSInteger)indexPathRow;

/**网络加载初始化*/
- (instancetype)initWithAlbumId:(NSInteger)albumId title:(NSString *)title isAsc:(BOOL)asc;
- (void)getItemModelData:(void(^)(NSError * error))completed;

- (NSString *)navTitle;
- (NSURL *)mCoverLarge;
- (NSString *)playTimes;
- (NSURL *)avatarPath;
- (NSString *)nickname;
- (NSString *)shortIntro;
- (NSString *)tags;



- (NSInteger)rowNumber;
- (NSString *)titleForRow:(NSInteger)indexPathRow;
- (NSString *)nicknameRorRow:(NSInteger)indexPathRow;
- (NSString *)authorRorRow:(NSInteger)indexPathRow;
- (NSURL *)coverMiddleForRow:(NSInteger)indexPathRow;
- (NSURL *)coverLargeForRow:(NSInteger)indexPathRow;
- (NSURL *)playURLForRow:(NSInteger)indexPathRow;
- (NSString *)playTimesForRow:(NSInteger)indexPathRow;
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow;
- (NSString *)createAtForRow:(NSInteger)indexPathRow;
/**时间-NSInteger*/
- (NSInteger)durationRorRow:(NSInteger)indexPathRow;
/**时间-string*/
- (NSString *)durationStringRorRow:(NSInteger)indexPathRow;



/** 通过行数，返回字典 */
- (DList *)trackForRow:(NSInteger)row;

@property(nonatomic)NSInteger albumId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic)BOOL asc;
@property(nonatomic,assign)NSInteger rowNumber;
@end
