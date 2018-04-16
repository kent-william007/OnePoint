//
//  XJRecommendViewController.m
//  music
//
//  Created by kent on 2017/8/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJRecommendViewController.h"
#import "SDCycleScrollView.h"
#import "MoreContentViewModel.h"
#import "XJRecommendViewCell.h"
#import "XJRecommendSectionTItle.h"
#import "XJSongViewController.h"


@interface XJRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView *mTableview;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)MoreContentViewModel *model;
@end

@implementation XJRecommendViewController

#pragma mark -LIFE CYCLE 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initTalbeview];
    [self startLoading];
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
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.sectionFooterHeight = 10;
    _mTableview.rowHeight = 80;
    _mTableview.tableHeaderView = [self tableViewHeader];
    [_mTableview registerClass:[XJRecommendViewCell class] forCellReuseIdentifier:@"XJRecommendViewCell"];
    
    __weak __typeof__(self) weakSelf = self;
    [self.model getDataCompletionHandle:^(NSError *error) {
        [weakSelf.view startTransitionAnimation];
        [weakSelf.mTableview reloadData];
        weakSelf.cycleScrollView.imageURLStringsGroup = [self.model focusImgURLArray];
        [weakSelf dismissLoadingView];
    }];
    
}

- (UIView *)tableViewHeader{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.52)];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.delegate = self;
    
    [header addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header).offset(12);
        make.leading.trailing.bottom.equalTo(header);
    }];

    return header;
}

#pragma mark -广告图点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"正在开发中...";
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];

    //NSLog(@"%i",index);
}

#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model numberOfRows:section];;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.model numberOfSections];;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }
    XJRecommendSectionTItle *header =[[XJRecommendSectionTItle alloc]initWithTitle:[self.model titleForSection:section] hasMore:YES titleTag:12];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJSongViewController *song = [[XJSongViewController alloc]initWithAlbumId:[self.model albumIdForIndexPath:indexPath]
                                                                        title:[self.model titleForRowAtIndexPath:indexPath]];
    
    [self.navigationController pushViewController:song animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJRecommendViewCell *cell = [[XJRecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJRecommendViewCell"];
    if (indexPath.section == 0) {
        [cell.hotRankIcon sd_setImageWithURL:[self.model coverURLForIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        cell.hotRankLabel.text = [self.model titleForRowAtIndexPath:indexPath];
    }else{
        [cell.coverIcon sd_setImageWithURL:[self.model coverURLForIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        cell.titleLabel.text = [self.model titleForRowAtIndexPath:indexPath];
        cell.introLabel.text = [self.model introForRowAtIndexPath:indexPath];
        cell.playCountLabel.text = [self.model playCountForRowAtIndexPath:indexPath];
        cell.albumRankLabel.text = [self.model albumRankForRowAtIndexPath:indexPath];
    }
    return cell;
}

#pragma mark -懒加载
- (MoreContentViewModel *)model{
    if (!_model) {
        _model = [[MoreContentViewModel alloc]initWithCategoryId:2 contentType:@"album"];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
