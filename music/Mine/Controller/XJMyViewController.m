//
//  XJMyViewController.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMyViewController.h"
#import "XJMyTableViewCell.h"
#import "XJHistory_Favorite_VC.h"
#import "XJShutInTime.h"
#import "XJCountTimer.h"

static NSString *identifier = @"XJMyTableViewCell_id";

@interface XJMyViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mTableview;
@end


@implementation XJMyViewController{
    NSArray *cellContent_Array;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _mTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_mTableview];
    [_mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    [_mTableview registerClass:[XJMyTableViewCell class] forCellReuseIdentifier:identifier];
    
    cellContent_Array = @[@{@"imageName":@"turntable_64px",@"title":@"我的收藏"},
                        @{@"imageName":@"compose_64px",@"title":@"播放历史"},
                        @{@"imageName":@"gear_64px",@"title":@"清理缓存"},
                        @{@"imageName":@"meter_64px",@"title":@"定时关机"},
                        @{@"imageName":@"lightbulb_64px",@"title":@"关于OnePoint"},
                        @{@"imageName":@"mail_64px",@"title":@"Content ME"}];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellContent_Array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        XJHistory_Favorite_VC *vc = [[XJHistory_Favorite_VC alloc]init];
        vc.sourceType = DataSourceFavorite;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1) {
        XJHistory_Favorite_VC *vc = [[XJHistory_Favorite_VC alloc]init];
        vc.sourceType = DataSourceHistory;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        XJShutInTime *shutView = [[XJShutInTime alloc]initWithFrame:self.view.frame];
        [shutView show];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XJMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.titleImageView.image = [UIImage imageNamed:cellContent_Array[indexPath.row][@"imageName"]];
    cell.titleLabel.text = cellContent_Array[indexPath.row][@"title"];
    if (indexPath.row == 3) {
        [XJCountTimer displayTime:^(NSString *displaytime) {
            cell.mdetailLabel.text = displaytime;
        }];
    }
    return cell;
}
@end
