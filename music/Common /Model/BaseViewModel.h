//
//  BaseViewModel.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelDelegate <NSObject>

@optional
- (void)getDataCompletionHandle:(void(^)(NSError * error))completed;
- (void)getLibraryDataCompletionHandle:(void(^)(NSError *error))completed;
- (void)getAlbumIdData:(NSInteger)albumId title:(NSString*)title  CompletionHandle:(void(^)(NSError *error))completed;

@end

@interface BaseViewModel : NSObject<BaseViewModelDelegate>

@property (nonatomic,strong) NSURLSessionDataTask *dataTask;

@end
