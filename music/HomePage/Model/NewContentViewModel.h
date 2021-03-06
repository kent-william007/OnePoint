//
//  NewContentViewModel.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
/**首页数据*/

#import "BaseViewModel.h"

@interface NewContentViewModel : BaseViewModel
- (instancetype)init;

@property(nonatomic,assign)NSInteger pageSize;

@property(nonatomic,assign)NSInteger rowNumber;

- (NSURL *)coverURLForRow:(NSInteger)row;

- (NSString *)introFroRow:(NSInteger)row;

- (NSString *)playsForRow:(NSInteger)row;

- (NSString *)tracksForRow:(NSInteger)row;

- (NSString *)trackTitleForRow:(NSInteger)row;

- (NSString *)titleForRow:(NSInteger)row;

- (NSInteger)albumIdForRow:(NSInteger)row;

- (NSURL *)urlForRow:(NSInteger)row;

//首页播放按钮状态
- (BOOL)playStatus:(NSInteger)row;

//改变首页播放按钮状态
- (void)setPlay:(NSInteger)row status:(BOOL)isPlay;

@end
