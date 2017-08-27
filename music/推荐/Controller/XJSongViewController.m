//
//  XJSongViewController.m
//  music
//
//  Created by kent on 2017/8/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJSongViewController.h"

@interface XJSongViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mTableview;
@end

@implementation XJSongViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    _mTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_mTableview];
    [_mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.mas_equalTo(-100);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.tableHeaderView = [self tableHeaderView];
}
- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor orangeColor];
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [headerView addSubview:header];
//    [header mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(headerView);
//    }];
    header.image = [UIImage imageNamed:@"compose_64px"];
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cdinde"];
    cell.textLabel.text = @"sfafsaf";
    return cell;
    
}
@end
