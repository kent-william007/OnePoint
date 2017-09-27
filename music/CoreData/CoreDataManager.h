//
//  CoreDataManager.h
//  music
//
//  Created by kent on 2017/9/8.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DList;

typedef NS_ENUM(NSUInteger,DataSourceType) {
    /**正常播放*/
    DataSourceNormal=0,
    /**历史播放*/
    DataSourceHistory,
    /**收藏播放*/
    DataSourceFavorite
};

@interface CoreDataManager : NSObject
@property(nonatomic,copy)NSString *modelName;
@property(nonatomic,assign)DataSourceType sourceType;
//- (instancetype)initWith:(DataSourceType)type;
- (void)coreDatWithDList:(DList*)songContent;
- (void)deleteItem:(DList *)songContent;
- (BOOL)checkItem:(DList *)songContent;
- (NSArray<DList *> *)getCoreData;
@end
