//
//  TracksViewModel.h
//  music
//
//  Created by kent on 2017/8/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "BaseViewModel.h"

@interface TracksViewModel : BaseViewModel
- (instancetype)initWithAlbumId:(NSInteger)albumId title:(NSString *)title isAsc:(BOOL)asc;
- (void)getItemModelData:(void(^)(NSError * error))completed;
- (NSURL *)playURLForRow:(NSInteger)indexPathRow;
- (NSURL *)coverURLForRow:(NSInteger)indexPathRow;

@property(nonatomic)NSInteger albumId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic)BOOL asc;
@property(nonatomic,assign)NSInteger rowNumber;
@end
