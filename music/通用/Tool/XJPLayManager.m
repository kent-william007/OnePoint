//
//  XJPLayManager.m
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPLayManager.h"
@interface XJPLayManager()
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic,strong) TracksViewModel *tracksVM;
@property (nonatomic,assign) NSInteger indexPathRow;
@property (nonatomic,assign) NSInteger rowNumber;
@end

@implementation XJPLayManager
+(instancetype)sharedInstance{
    static XJPLayManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XJPLayManager alloc]init];
    });
    return manager;
}
- (void)pauseMusic:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    _currentPlayerItem = [[AVPlayerItem alloc]initWithURL:url];
    _player = [[AVPlayer alloc]initWithPlayerItem:_currentPlayerItem];
    [_player play];
}
-(void)playWithModel:(TracksViewModel *)tracks indexPathRow:(NSInteger)indexPathRow{
    _tracksVM = tracks;
    _rowNumber = _tracksVM.rowNumber;
    _indexPathRow = indexPathRow;
    
    NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    _player = [[AVPlayer alloc]initWithPlayerItem:_currentPlayerItem];
    [_player play];
    
}
@end
