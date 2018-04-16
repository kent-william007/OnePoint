//
//  XJNetManager.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJNetManager : NSObject
+ (id)GET:(NSString *)path paramaters:(NSDictionary *)params complationHandle:(void(^)(id responseObject,NSError *error))completed;
+ (void)cancelTask;
@end
