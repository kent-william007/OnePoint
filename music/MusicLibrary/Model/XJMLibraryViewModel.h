//
//  XJMLibraryViewModel.h
//  music
//
//  Created by kent on 2017/9/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@interface XJMLibraryViewModel : BaseViewModel
- (instancetype)initWithCategoryId:(NSInteger)categoryId tagsName:(NSString *)tagName page:(NSUInteger)page;
/**分行*/
- (NSInteger)numberOfRows;
/**图标*/
- (NSURL *)coverURLForIndexPath:(NSIndexPath *)indexPath;
/**通过分组数和行数(IndexPath), 获取类别ID*/
- (NSInteger)albumIdForIndexPath:(NSIndexPath *)indexPath ;
/**row标题*/
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexpath;
/**row-introLabel*/
- (NSString *)introForRowAtIndexPath:(NSIndexPath *)indexpath;
/**row-playCount*/
- (NSString *)playCountForRowAtIndexPath:(NSIndexPath *)indexpath;
/**row-albumRank*/
- (NSString *)albumRankForRowAtIndexPath:(NSIndexPath *)indexpath;

@end
