//
//  NSString+Extension.h
//  music
//
//  Created by kent on 2017/9/2.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - 时间转化
@interface NSString (Extension)
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval;
@end
