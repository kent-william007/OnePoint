//
//  MoreContentViewModel.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "MoreContentViewModel.h"
#import "XJMoreNetManager.h"
#import "ContentsModel.h"

@interface MoreContentViewModel()
@property(nonatomic)NSInteger categoryId;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)ContentsModel *model;
@end


@implementation MoreContentViewModel
- (instancetype)initWithCategoryId:(NSInteger)categoryId contentType:(NSString *)type{
    if (self = [super init]) {
        _categoryId = categoryId;
        _type = type;
    }
    return self;
}

- (instancetype)GETCurrentInstanceWithCategoryId:(NSInteger)categoryId contentType:(NSString *)type{
    if (!self) {
        return [[MoreContentViewModel alloc] initWithCategoryId:categoryId contentType:type];
    }
    return self;
}

- (void)getDataCompletionHandle:(void(^)(NSError *error))completed{
    self.dataTask = [XJMoreNetManager getContentsForCategoryId:_categoryId contentType:_type completionHandle:^(id responseObject, NSError *error) {
        self.model = responseObject;
        //NSLog(@"%@",responseObject);
        completed(error);

    }];
}

/**轮播图*/
- (NSArray *)focusImgURLArray{
    NSMutableArray *m_array = [NSMutableArray array];
    [self.model.focusImages.list enumerateObjectsUsingBlock:^(ContentFocusimages_list * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [m_array addObject:obj.pic];
    }];
    return [m_array copy];
}

/**图标*/
- (NSURL *)coverURLForIndexPath:(NSIndexPath *)indexPath{
    NSString *path;
    if (indexPath.section == 0) {
        path = self.model.categoryContents.list[indexPath.section].list[indexPath.row].coverPath;
    }else{
       path = self.model.categoryContents.list[indexPath.section].list[indexPath.row].coverMiddle;
    }
    return [NSURL URLWithString:path];
}

/**通过分组数和行数(IndexPath), 获取类别ID*/
- (NSInteger)albumIdForIndexPath:(NSIndexPath *)indexPath {
    return self.model.categoryContents.list[indexPath.section].list[indexPath.row].albumId;
}

/**分组*/
- (NSInteger)numberOfSections{
    return self.model.categoryContents.list.count;
}

/**分行*/
- (NSInteger)numberOfRows:(NSInteger)section{
    return self.model.categoryContents.list[section].list.count;
}

/**分组标题*/
- (NSString *)titleForSection:(NSInteger)section{
    return self.model.categoryContents.list[section].title;
}

/**row标题*/
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexpath{
    return self.model.categoryContents.list[indexpath.section].list[indexpath.row].title;
}
/**row-introLabel*/
- (NSString *)introForRowAtIndexPath:(NSIndexPath *)indexpath{
    return self.model.categoryContents.list[indexpath.section].list[indexpath.row].intro;
}

/**row-playCount*/
- (NSString *)playCountForRowAtIndexPath:(NSIndexPath *)indexpath{
    CGFloat playCount = self.model.categoryContents.list[indexpath.section].list[indexpath.row].playsCounts/10000.00;
    return [NSString stringWithFormat:@"%.2f万",playCount];
}

/**row-albumRank*/
- (NSString *)albumRankForRowAtIndexPath:(NSIndexPath *)indexpath{
    return @"0集";
}

- (NSString *)contentListName:(NSIndexPath *)indexPath{
    return self.model.tags.list[indexPath.section].tname;
}



@end
