//
//  XJPLayManager.h
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TracksViewModel.h"

@interface XJPLayManager : NSObject

@property(nonatomic,strong)AVPlayer *player;

+ (instancetype)sharedInstance;
- (void)pauseMusic:(NSString *)urlString;
- (void)playWithModel:(TracksViewModel *)tracks indexPathRow:(NSInteger ) indexPathRow;
@end
