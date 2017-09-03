//
//  MoreContentViewModel.h
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
@interface MoreContentViewModel : BaseViewModel

- (instancetype)initWithCategoryId:(NSInteger)categoryId contentType:(NSString *)type;

/**通过分组数和行数(IndexPath), 获取类别ID */
- (NSInteger)albumIdForIndexPath:(NSIndexPath *)indexPath;

/**轮播图的URL*/
- (NSArray *)focusImgURLArray;

/**图标*/
- (NSURL *)coverURLForIndexPath:(NSIndexPath *)indexPath;

/**分组*/
- (NSInteger)numberOfSections;

/**分行*/
- (NSInteger)numberOfRows:(NSInteger)section;

/**行标题*/
- (NSString *)titleForSection:(NSInteger)section;

/**row标题*/
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexpath;

/**row-introLabel*/
- (NSString *)introForRowAtIndexPath:(NSIndexPath *)indexpath;

/**row-playCount*/
- (NSString *)playCountForRowAtIndexPath:(NSIndexPath *)indexpath;

/**row-albumRank*/
- (NSString *)albumRankForRowAtIndexPath:(NSIndexPath *)indexpath;

@end
