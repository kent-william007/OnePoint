//
//  XJMLibraryModel.h
//  music
//
//  Created by kent on 2017/9/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Library_List;

@interface XJMLibraryModel : NSObject

@property(nonatomic,assign)NSInteger pageId;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,copy)NSArray *subfields;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger maxPageId;
@property(nonatomic,copy)NSString * msg;
@property(nonatomic,copy)NSArray<Library_List *> *list;
@property(nonatomic,assign)NSInteger ret;
@end

@interface Library_List : NSObject
@property(nonatomic,copy)NSString *albumCoverUrl290;
@property(nonatomic)long long albumId;
@property(nonatomic,assign)NSInteger commentsCount;
@property(nonatomic,copy)NSString *coverLarge;
@property(nonatomic,copy)NSString *coverMiddle;
@property(nonatomic,copy)NSString *coverSmall;
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,assign)BOOL isDraft;
@property(nonatomic,assign)NSInteger isFinished;
@property(nonatomic,assign)BOOL isPaid;
@property(nonatomic,assign)BOOL isVipFree;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,assign)NSInteger playsCounts;
@property(nonatomic,assign)NSInteger priceTypeId;
@property(nonatomic,copy)NSString *provider;
@property(nonatomic,assign)NSInteger refundSupportType;
@property(nonatomic,assign)NSInteger serialState;
@property(nonatomic,copy)NSString *tags;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)NSInteger trackId;
@property(nonatomic,copy)NSString *trackTitle;
@property(nonatomic,assign)NSInteger tracks;
@property(nonatomic,assign)NSInteger uid;
@end