//
//  NewContentViewModel.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "NewContentViewModel.h"
#import "XJMoreNetManager.h"
#import "NewCategoryModel.h"
#import "DestinationModel.h"

@interface NewContentViewModel()
@property (nonatomic,strong)NewCategoryModel *model;
@property (nonatomic,strong)DestinationModel *d_model;
@end

@implementation NewContentViewModel
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)getDataCompletionHandle:(void(^)(NSError *))completed{
  self.dataTask = [XJMoreNetManager getTracksForMuisc:0 completionHandle:^(id responseObject, NSError *error) {
      if (responseObject) {
          self.model = responseObject;
      }
      completed(error);
    }];
}

- (void)getAlbumIdData:(NSInteger)albumId title:(NSString*)title  CompletionHandle:(void(^)(NSError *))completed{
    self.dataTask = [XJMoreNetManager getTracksForAlbumId:albumId mainTitle:title idAsc:YES completionHandle:^(id responseObject, NSError *error) {
        NSLog(@"%@",responseObject);
        self.d_model = responseObject;
    }];
}



- (NSInteger)pageSize{
    return self.model.pageSize;
}
- (NSInteger)rowNumber{
    return self.model.list.count;
}

- (NSURL *)coverURLForRow:(NSInteger)row{
    NSString *path = self.model.list[row].coverLarge;
    return [NSURL URLWithString:path];
}

- (NSString *)introFroRow:(NSInteger)row{
    return self.model.list[row].intro;
}

- (NSString *)playsForRow:(NSInteger)row{
    NSInteger count = self.model.list[row].playsCounts;
    return [NSString stringWithFormat:@"%ld",(long)count];
}

- (NSString *)tracksForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld集",(long)self.model.list[row].tracksCounts];
}

- (NSString *)trackTitleForRow:(NSInteger)row{
    return self.model.list[row].tracktitle;
}

- (NSString *)titleForRow:(NSInteger)row{
    return self.model.list[row].title;
}

- (NSInteger)albumIdForRow:(NSInteger)row{
    return self.model.list[row].albumid;
}

- (NSURL *)urlForRow:(NSInteger)row{
    NSURL *url = [[NSURL alloc]initWithString:self.model.list[row].weburl];
    return url;
}

@end
