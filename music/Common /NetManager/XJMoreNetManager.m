//
//  XJMoreNetManager.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMoreNetManager.h"
#import "NewCategoryModel.h"
#import "MJExtension.h"
#import "DestinationModel.h"
#import "ContentsModel.h"
#import "XJMLibraryModel.h"

#define kURLVersion @"version":@"4.3.26.2"
#define kURLDevice @"device":@"ios"
#define kURLPosition @"position":@1
#define KURLScale @"scale":@2
#define kURLPageID @"pageId":@1
#define kURLStatus  @"status":@0
#define kURLCalcDimension @"calcDimension":@"hot"

@implementation XJMoreNetManager

/**获取主页，不同风格音乐*/
+ (id)getTracksForMuisc:(NSInteger)modelId completionHandle:(void (^)(id, NSError *))completed{
//    NSString *path = [NSString stringWithFormat:@"http://o8yhyhsyd.bkt.clouddn.com/musicAlbum.json"];
    NSString *path = [NSString stringWithFormat:@"http://www.ximalaya.com/dq/all/"];


    return  [self GET:path paramaters:nil complationHandle:^(id responseObject, NSError *error) {

        if (responseObject) {
            completed([NewCategoryModel mj_objectWithKeyValues:responseObject],nil);
        }else{
            completed(nil,error);
        }
    }];
}

/**获取不同音乐风格专辑里的曲目列表*/
+ (id)getTracksForAlbumId:(NSInteger)albumId mainTitle:(NSString *)title idAsc:(BOOL)isAsc completionHandle:(void (^)(id, NSError *))completed{
    NSDictionary *params = @{@"albumId":@(albumId),@"title":title,@"isAsc":@(isAsc),kURLDevice,kURLPosition};
    NSString *path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20",(long)albumId];
    return [self GET:path paramaters:params complationHandle:^(id responseObject, NSError *error) {

        completed([DestinationModel mj_objectWithKeyValues:responseObject],nil);
    }];
}

/**获取推荐音乐*/
+ (id)getContentsForCategoryId:(NSInteger)categoryID contentType:(NSString *)type completionHandle:(void(^)(id responseObject,NSError *error))completed{
    
    NSDictionary *params = @{@"categoryId":@(categoryID),@"contentType":type,kURLDevice,KURLScale,kURLVersion};
    return [self GET:@"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends" paramaters:params complationHandle:^(id responseObject, NSError *error) {
        completed([ContentsModel mj_objectWithKeyValues:responseObject],nil);
    }];
}


/**  解析,内容分类数据模型*/
// http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=1&device=android&pageId=1&pageSize=20&status=0&tagName=%E6%AD%A3%E8%83%BD%E9%87%8F%E5%8A%A0%E6%B2%B9%E7%AB%99
+ (id)getCategoryForCategoryId:(NSInteger)categoryId tagName:(NSString *)name pageSize:(NSInteger)size completionHandle:(void(^)(id responseObject, NSError *error))completed {
    // tagName中文需要转换成UTF8格式, 这个另类   直接需要中文
    //  NSString *tagName = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//网址转化
    NSDictionary *params = @{@"categoryId":@(categoryId),@"pageSize":@(size),@"tagName":name, kURLPageID,kURLDevice,kURLStatus,kURLCalcDimension};
    return [self GET:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album" paramaters:params complationHandle:^(id responseObject, NSError *error) {
        if (error) {
            
        }else{
           completed([XJMLibraryModel mj_objectWithKeyValues:responseObject],nil);
        }
    }];
}

+ (void)cancelTask{
    
}

@end
