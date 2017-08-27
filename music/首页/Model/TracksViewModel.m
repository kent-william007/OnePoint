//
//  TracksViewModel.m
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "TracksViewModel.h"
#import "XJMoreNetManager.h"
#import "DestinationModel.h"

@interface TracksViewModel()
@property(nonatomic,strong)DestinationModel *model;
@property(nonatomic)NSInteger itemModel;
@end


@implementation TracksViewModel
- (instancetype)initWithAlbumId:(NSInteger)albumId title:(NSString *)title isAsc:(BOOL)asc{
    
    if (self = [super init]) {
        _albumId = albumId;
        _title = title;
        _asc = asc;
    }
    return self;
}
- (void)getItemModelData:(void (^)(NSError * error))completed{
    self.dataTask = [XJMoreNetManager getTracksForAlbumId:_albumId mainTitle:_title idAsc:_albumId completionHandle:^(id responseObject, NSError *error) {
        self.model = responseObject;
        completed(error);
    }];
}
- (NSInteger)rowNumber{
        return self.model.tracks.list.count;
}

/**音乐URL*/
- (NSURL *)playURLForRow:(NSInteger)indexPathRow{
    NSString *path = self.model.tracks.list[indexPathRow].playUrl64;
    return [NSURL URLWithString:path];
}

/**专辑小图标*/
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow{
    NSString *path = self.model.tracks.list[indexPathRow].coverSmall;
    return [NSURL URLWithString:path];
}
@end
