//
//  TracksViewModel.h
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
/**首页Cell点击加载数据*/

#import "BaseViewModel.h"

@interface TracksViewModel : BaseViewModel
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
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow;
- (NSString *)createAtForRow:(NSInteger)indexPathRow;
/**时间-NSInteger*/
- (NSInteger)durationRorRow:(NSInteger)indexPathRow;
/**时间-string*/
- (NSString *)durationStringRorRow:(NSInteger)indexPathRow;


@property(nonatomic)NSInteger albumId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic)BOOL asc;
@property(nonatomic,assign)NSInteger rowNumber;
@end
