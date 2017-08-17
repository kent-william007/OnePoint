//
//  DestinationModel.h
//  music
//
//  Created by kent on 2017/8/17.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

/*字段N多，对照着报文，撸下来了*/

@class Album,Tracks;
@interface DestinationModel : NSObject
@property(nonatomic,strong)Album *album;
@property(nonatomic,strong)Tracks *tracks;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic,assign)NSInteger ret;
@end

@interface Album : NSObject
@property(nonatomic,assign)NSInteger albumId;
@property(nonatomic,copy)NSString * avatarPath;
@property(nonatomic,assign)NSInteger canInviteListen;
@property(nonatomic,assign)NSInteger canShareAndStealListen;
@property(nonatomic,assign)NSInteger categoryId;
@property(nonatomic,copy)NSString * categoryName;
@property(nonatomic,copy)NSString * coverLarge;
@property(nonatomic,copy)NSString * coverLargePop;
@property(nonatomic,copy)NSString * coverMiddle;
@property(nonatomic,copy)NSString * coverOrigin;
@property(nonatomic,copy)NSString * coverSmall;
@property(nonatomic,copy)NSString * coverWebLarge;
@property(nonatomic,assign)long createdAt;
@property(nonatomic,copy)NSString * customSubTitle;
@property(nonatomic,assign)NSInteger followers;
@property(nonatomic,assign)NSInteger hasNew;
@property(nonatomic,copy)NSString * intro;
@property(nonatomic,copy)NSString * introRich;
@property(nonatomic,assign)NSInteger isDraft;
@property(nonatomic,assign)NSInteger isFavorite;
@property(nonatomic,assign)NSInteger isFollowed;
@property(nonatomic,assign)NSInteger isPaid;
@property(nonatomic,assign)NSInteger isRecordDesc;
@property(nonatomic,assign)NSInteger isVerified;
@property(nonatomic,assign)long lastUptrackAt;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,assign)NSInteger offlineReason;
@property(nonatomic,assign)NSInteger offlineType;
@property(nonatomic,assign)NSInteger playTimes;
@property(nonatomic,assign)NSInteger playTrackId;
@property(nonatomic,assign)NSInteger refundSupportType;
@property(nonatomic,assign)NSInteger serialState;
@property(nonatomic,assign)NSInteger serializeStatus;
@property(nonatomic,assign)NSInteger shares;
@property(nonatomic,copy)NSString * shortIntro;
@property(nonatomic,copy)NSString * shortIntroRich;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString * tags;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger tracks;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,assign)NSInteger unReadAlbumCommentCount;
@property(nonatomic,assign)long updatedAt;
@end

@class DList;
@interface Tracks : NSObject
@property(nonatomic,strong)NSArray<DList*> *list;
@property(nonatomic,assign)NSInteger maxPageId;
@property(nonatomic,assign)NSInteger pageId;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger totalCount;
@end

@interface DList : NSObject
@property(nonatomic,assign)NSInteger albumId;
@property(nonatomic,assign)NSInteger comments;
@property(nonatomic,copy)NSString * coverLarge;
@property(nonatomic,copy)NSString * coverMiddle ;
@property(nonatomic,copy)NSString * coverSmall;
@property(nonatomic,assign)long long createdAt;
@property(nonatomic,assign)NSInteger duration;
@property(nonatomic,assign)NSInteger isDraft;
@property(nonatomic,assign)NSInteger isPaid;
@property(nonatomic,assign)NSInteger isPublic;
@property(nonatomic,assign)NSInteger isVideo;
@property(nonatomic,assign)NSInteger likes;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,assign)NSInteger opType;
@property(nonatomic,copy)NSString * playPathAacv164;
@property(nonatomic,copy)NSString * playPathAacv224;
@property(nonatomic,copy)NSString * playPathHq ;
@property(nonatomic,copy)NSString * playUrl32;
@property(nonatomic,copy)NSString * playUrl64;
@property(nonatomic,assign)NSInteger playtimes;
@property(nonatomic,assign)NSInteger processState;
@property(nonatomic,assign)NSInteger shares;
@property(nonatomic,copy)NSString * smallLogo;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger trackId;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,assign)NSInteger userSource;
@end
