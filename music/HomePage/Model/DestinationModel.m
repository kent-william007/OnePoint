//
//  DestinationModel.m
//  music
//
//  Created by kent on 2017/8/17.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "DestinationModel.h"

/**每个对应的model都必须要有实现，否则会报错
   当一个model里含有另一model时，记得实现objectClassInArray
   否则dictionary转model会失败
 */
@class Album,Tracks,DList;
@implementation DestinationModel
+ (NSDictionary *)objectClassInArray{
    return @{@"album" : [Album class],
             @"tracks":[Tracks class]};
}
@end

@implementation Album

@end

@implementation Tracks
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [DList class]};
}
@end

@implementation DList

@end