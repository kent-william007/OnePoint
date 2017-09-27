//
//  FavoriteModel+CoreDataProperties.h
//  
//
//  Created by kent on 2017/9/18.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FavoriteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *albumId;
@property (nullable, nonatomic, retain) NSNumber *comments;
@property (nullable, nonatomic, retain) NSString *coverLarge;
@property (nullable, nonatomic, retain) NSString *coverMiddle;
@property (nullable, nonatomic, retain) NSString *coverSmall;
@property (nullable, nonatomic, retain) NSNumber *createdAt;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSNumber *isDraft;
@property (nullable, nonatomic, retain) NSNumber *isPaid;
@property (nullable, nonatomic, retain) NSNumber *isPublic;
@property (nullable, nonatomic, retain) NSNumber *isVideo;
@property (nullable, nonatomic, retain) NSNumber *likes;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSNumber *opType;
@property (nullable, nonatomic, retain) NSString *playPathAacv164;
@property (nullable, nonatomic, retain) NSString *playPathAacv224;
@property (nullable, nonatomic, retain) NSString *playPathHq;
@property (nullable, nonatomic, retain) NSNumber *playtimes;
@property (nullable, nonatomic, retain) NSString *playUrl32;
@property (nullable, nonatomic, retain) NSString *playUrl64;
@property (nullable, nonatomic, retain) NSNumber *processState;
@property (nullable, nonatomic, retain) NSNumber *shares;
@property (nullable, nonatomic, retain) NSString *smallLogo;
@property (nullable, nonatomic, retain) NSNumber *status;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *trackId;
@property (nullable, nonatomic, retain) NSNumber *uid;
@property (nullable, nonatomic, retain) NSNumber *userSource;

@end

NS_ASSUME_NONNULL_END
