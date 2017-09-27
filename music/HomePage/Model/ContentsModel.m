//
//  ContentsModel.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "ContentsModel.h"

@implementation ContentsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [ContentTags class],
             @"categoryContents":[ContentCategorycontents class],
             @"focusImages":[ContentFocusimages class]};
}
@end

/**Categorycontents-----------------------------*/
@implementation ContentCategorycontents
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CCcontents_list class]};
}
@end

@implementation CCcontents_list
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CCcontents_list_list class]};
}
@end

@implementation CCcontents_list_list
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CCcontents_list_list class]};
}
@end
/**Categorycontents-END----------------------*/





/**ContentFocusimages-----------------------------*/
@implementation ContentFocusimages
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ContentFocusimages_list class]};
}
@end

@implementation ContentFocusimages_list

@end
/**ContentFocusimages-END-----------------------------*/



/**ContentTags-----------------------------*/
@implementation ContentTags
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ContentTags_list class]};
}
@end

@implementation ContentTags_list

@end
/**ContentTags-END-----------------------------*/
