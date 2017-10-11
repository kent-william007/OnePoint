//
//  XJMLibraryDetailVC.m
//  music
//
//  Created by kent on 2017/9/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMLibraryDetailVC.h"
#import "XJMLibraryViewModel.h"
#import "XJSongViewController.h"
#import "XJRecommendViewCell.h"

@interface XJMLibraryDetailVC()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XJMLibraryViewModel *model;
@property(nonatomic,strong)UITableView *mTableview;
@end

@implementation XJMLibraryDetailVC
#pragma mark -LIFE CYCLE
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initTalbeview];
    self.title = self.contentType;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark -init TableView
- (void)initTalbeview{
    self.view.backgroundColor = [UIColor clearColor];
    _mTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_mTableview];
    [_mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.rowHeight = 80;
    [_mTableview registerClass:[XJRecommendViewCell class] forCellReuseIdentifier:@"XJRecommendViewCell"];
    
    __weak __typeof__(self) weakSelf = self;
    [self.model getLibraryDataCompletionHandle:^(NSError *error) {
        [weakSelf.view startTransitionAnimation];
        [weakSelf.mTableview reloadData];
    }];
    
}


#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model numberOfRows];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJSongViewController *song = [[XJSongViewController alloc]initWithAlbumId:[self.model albumIdForIndexPath:indexPath]
                                                                        title:[self.model titleForRowAtIndexPath:indexPath]];
    [self.navigationController pushViewController:song animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJRecommendViewCell *cell = [[XJRecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJRecommendViewCell"];
    [cell.coverIcon sd_setImageWithURL:[self.model coverURLForIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
    cell.titleLabel.text = [self.model titleForRowAtIndexPath:indexPath];
    cell.introLabel.text = [self.model introForRowAtIndexPath:indexPath];
    cell.playCountLabel.text = [self.model playCountForRowAtIndexPath:indexPath];
    cell.albumRankLabel.text = [self.model albumRankForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark -懒加载
- (XJMLibraryViewModel *)model{
    if (!_model) {
        _model = [[XJMLibraryViewModel alloc]initWithCategoryId:2 tagsName:_contentType page:10];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
