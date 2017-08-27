//
//  NewCategoryModel.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "NewCategoryModel.h"

@implementation NewCategoryModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NewCategoryList class]};
}
@end


@implementation NewCategoryList
- (instancetype)init{
    if (self = [super init]) {
        self.play = NO;
    }
    return self;
}
@end
