//
//  ContentsModel.h
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentCategorycontents,ContentFocusimages,ContentTags,CCcontents_list,CCcontents_list_list,ContentFocusimages_list,ContentTags_list;

@interface ContentsModel : NSObject
@property (nonatomic, strong) ContentTags *tags;
@property (nonatomic, strong) ContentCategorycontents *categoryContents;
@property (nonatomic, assign) BOOL hasRecommendedZones;
@property (nonatomic, strong) ContentFocusimages *focusImages;
@property (nonatomic, copy)   NSString *msg;
@property (nonatomic, assign) NSInteger ret;
@end

/**Categorycontents*/
@interface ContentCategorycontents : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger ret;
@property(nonatomic,strong)NSArray<CCcontents_list *> *list;
@end

@interface CCcontents_list : NSObject
@property(nonatomic,copy)NSString *calcDimension;
@property(nonatomic,strong)NSString *contentType;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)NSInteger moduleType;
@property(nonatomic,copy)NSString *tagName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray<CCcontents_list_list *> *list;
@end

@interface CCcontents_list_list : NSObject
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


//---------------------
@property(nonatomic,copy)NSString *calcPeriod;
@property(nonatomic,assign)NSInteger categoryId;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSString *coverPath;
@property(nonatomic,assign)BOOL isAllPaid;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,assign)NSInteger maxPageId;
@property(nonatomic,assign)NSInteger pageId;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger period;
@property(nonatomic,assign)NSInteger rankingListId;
@property(nonatomic,copy)NSString * rankingRule;
@property(nonatomic,assign)NSInteger ret;
@property(nonatomic,copy)NSString * subtitle;
@property(nonatomic,assign)NSInteger top;
@property(nonatomic,assign)NSInteger totalCount;

@end
/**Categorycontents-END*/


/**ContentFocusimages*/
@interface ContentFocusimages : NSObject
@property(nonatomic,assign)NSInteger ret;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,strong)NSArray<ContentFocusimages_list *> *list;
@end

@interface ContentFocusimages_list : NSObject
@property(nonatomic,assign)NSInteger roomId;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,copy)NSString * shortTitle;
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)NSString * pic;
@property(nonatomic,assign)NSInteger trackId;
@property(nonatomic,assign)NSInteger focusCurrentId;
@property(nonatomic)BOOL isShare;
@property(nonatomic)BOOL is_External_url;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString * longTitle;
@end
/**ContentFocusimages-END*/

/**ContentTags*/
@interface ContentTags : NSObject
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger maxPageId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray<ContentTags_list *> *list;
@end

@interface ContentTags_list : NSObject
@property(nonatomic,copy)NSString *tname;
@property(nonatomic,assign)NSInteger category_id;
@end
/**ContentTags-END*/


