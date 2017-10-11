//
//  XJMLibraryModel.m
//  music
//
//  Created by kent on 2017/9/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMLibraryModel.h"

@implementation XJMLibraryModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [Library_List class]};
}

@end

@implementation Library_List

@end