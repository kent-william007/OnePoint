//
//  XJMoreNetManager.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJNetManager.h"

@interface XJMoreNetManager : XJNetManager
+ (id)getTracksForMuisc:(NSInteger)modelId completionHandle:(void(^)(id responseObject,NSError *error))completed;
+ (id)getTracksForAlbumId:(NSInteger)albumId mainTitle:(NSString *)title idAsc:(BOOL)isAsc completionHandle:(void(^)(id responseObject,NSError *error))completed;
@end
