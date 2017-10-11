//
//  XJMLibraryViewModel.m
//  music
//
//  Created by kent on 2017/9/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMLibraryViewModel.h"
#import "XJMLibraryModel.h"
#import "XJMoreNetManager.h"

@interface XJMLibraryViewModel()
@property(nonatomic)NSInteger categoryId;
@property(nonatomic,copy)NSString *tagName;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)XJMLibraryModel *model;
@end

@implementation XJMLibraryViewModel

- (instancetype)initWithCategoryId:(NSInteger)categoryId tagsName:(NSString *)tagName page:(NSUInteger)page{
    if (self = [super init]) {
        _categoryId = categoryId;
        _tagName = tagName;
        _page = page;
    }
    return self;
}

- (void)getLibraryDataCompletionHandle:(void (^)(NSError *))completed{
    self.dataTask = [XJMoreNetManager getCategoryForCategoryId:_categoryId tagName:_tagName pageSize:_page completionHandle:^(id responseObject, NSError *error) {
        self.model = responseObject;
        completed(error);
    }];

}

/**分行*/
- (NSInteger)numberOfRows{
    return self.model.list.count;
}


/**图标*/
- (NSURL *)coverURLForIndexPath:(NSIndexPath *)indexPath{
    NSString *path = self.model.list[indexPath.row].coverMiddle;
    return [NSURL URLWithString:path];
}

/**通过分组数和行数(IndexPath), 获取类别ID*/
- (NSInteger)albumIdForIndexPath:(NSIndexPath *)indexPath {
    return self.model.list[indexPath.row].albumId;
}



/**row标题*/
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexpath{
    return self.model.list[indexpath.row].title;
}
/**row-introLabel*/
- (NSString *)introForRowAtIndexPath:(NSIndexPath *)indexpath{
    return self.model.list[indexpath.row].intro;
}

/**row-playCount*/
- (NSString *)playCountForRowAtIndexPath:(NSIndexPath *)indexpath{
    CGFloat playCount = self.model.list[indexpath.row].playsCounts/10000.00;
    return [NSString stringWithFormat:@"%.2f万",playCount];
}

/**row-albumRank*/
- (NSString *)albumRankForRowAtIndexPath:(NSIndexPath *)indexpath{
    return @"0集";
}


@end
