//
//  NewCategoryModel.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewCategoryList;
@interface NewCategoryModel : NSObject

@property(nonatomic,assign)NSInteger maxPageId;

@property(nonatomic,copy)NSString * msg;

@property(nonatomic,assign)NSInteger pageId;

@property(nonatomic,assign)NSInteger pageSize;

@property(nonatomic,assign)NSInteger ret;

@property(nonatomic,copy)NSArray *subfields;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)NSInteger totalCount;

@property(nonatomic,copy)NSArray<NewCategoryList *> *list;

@end


@interface NewCategoryList : NSObject
@property(nonatomic,copy)NSString *albumCoverUrl290;

@property(nonatomic,assign)NSInteger albumid;

@property(nonatomic,assign)NSInteger commentsCount;

@property(nonatomic,copy)NSString *coverLarge;

@property(nonatomic,copy)NSString *coverMiddle;

@property(nonatomic,copy)NSString *coverSmall;

@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString *intro;

@property(nonatomic,assign)NSInteger isFinished;

@property(nonatomic,assign)NSInteger isPaid;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,assign)NSInteger playsCounts;

@property(nonatomic,assign)NSInteger serialState;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)NSInteger trackid;

@property(nonatomic,assign)NSInteger tracks;

@property(nonatomic,copy)NSString *tracktitle;

@property(nonatomic,assign)NSInteger uid;

@property(nonatomic,copy)NSString *weburl;

@property(nonatomic,assign)long long lastUptrackAt;

@property (nonatomic, assign) NSInteger tracksCounts;

@end
