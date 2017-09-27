//
//  SongsModel.m
//  music
//
//  Created by kent on 2017/9/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "SongsModel.h"
#import <objc/runtime.h>
@implementation SongsModel

//获取对象的所有属性
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


@end
