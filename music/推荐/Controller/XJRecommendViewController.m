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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initTalbeview];
}

- (void)initTalbeview{
    
    _mTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_mTableview];
    [_mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.estimatedRowHeight = 100;
    _mTableview.tableHeaderView = [self tableViewHeader];
    [_mTableview registerClass:[XJRecommendViewCell class] forCellReuseIdentifier:@"XJRecommendViewCell"];
    
    __weak __typeof__(self) weakSelf = self;
    [self.model getDataCompletionHandle:^(NSError *error) {
        [weakSelf.mTableview reloadData];
        weakSelf.cycleScrollView.imageURLStringsGroup = [self.model focusImgURLArray];
    }];
}

- (UIView *)tableViewHeader{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.52)];

    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imagesGroup:nil];
    _cycleScrollView.backgroundColor = [UIColor brownColor];
    _cycleScrollView.delegate = self;
    
    [header addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(header);
    }];

    return header;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%i",index);
}


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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XJSongViewController *song = [[XJSongViewController alloc]init];
    [self.navigationController pushViewController:song animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJRecommendViewCell *cell = [[XJRecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJRecommendViewCell"];
    if (indexPath.section == 0) {
        [cell.hotRankIcon sd_setImageWithURL:[self.model coverURLForIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@"avatar_bg"]];
        cell.hotRankLabel.text = [self.model titleForRowAtIndexPath:indexPath];
    }else{
        [cell.coverIcon sd_setImageWithURL:[self.model coverURLForIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@"avatar_bg"]];
        cell.titleLabel.text = [self.model titleForRowAtIndexPath:indexPath];
        cell.introLabel.text = [self.model introForRowAtIndexPath:indexPath];
        cell.playCountLabel.text = [self.model playCountForRowAtIndexPath:indexPath];
        cell.albumRankLabel.text = [self.model albumRankForRowAtIndexPath:indexPath];
    }
    return cell;
}

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
