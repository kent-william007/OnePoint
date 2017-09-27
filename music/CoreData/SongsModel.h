//
//  SongsModel.h
//  music
//
//  Created by kent on 2017/9/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongsModel : NSManagedObject

- (NSArray *)getAllProperties;

@end

NS_ASSUME_NONNULL_END

#import "SongsModel+CoreDataProperties.h"
