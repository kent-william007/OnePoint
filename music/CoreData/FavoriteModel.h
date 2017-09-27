//
//  FavoriteModel.h
//  
//
//  Created by kent on 2017/9/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteModel : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (NSArray *)getAllProperties;
@end

NS_ASSUME_NONNULL_END

#import "FavoriteModel+CoreDataProperties.h"
