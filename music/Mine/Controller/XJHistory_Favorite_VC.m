//
//  XJHistory_Favorite_VC.m
//  music
//
//  Created by kent on 2017/9/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJHistory_Favorite_VC.h"
#import "SongsModel.h"
#import "XJRecommendViewCell.h"
#import "XJPLayManager.h"
#import "XJSongViewController.h"


@interface XJHistory_Favorite_VC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mTableview;
@property(nonatomic,strong)TracksViewModel *vModel;
@end

@implementation XJHistory_Favorite_VC
#pragma mark -LIFE CYCLE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vModel = [[TracksViewModel alloc]initWithSourceType:self.sourceType];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTalbeview];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (self.sourceType) {
        case DataSourceHistory:
            self.title = @"播放历史";
            break;
        case DataSourceFavorite:
            self.title = @"我的收藏";
            break;
        default:
            break;
    }
}

#pragma mark -init TableView
- (void)initTalbeview{
    self.view.backgroundColor = [UIColor orangeColor];
    _mTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_mTableview];
    [_mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.rowHeight = 80;
    _mTableview.sectionFooterHeight = 10;
    [_mTableview registerClass:[XJRecommendViewCell class] forCellReuseIdentifier:@"XJRecommendViewCell"];
    
}


#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_vModel rowNumber];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"musicURL"] = [_vModel playURLForRow:indexPath.row];
    userInfo[@"indexPathRow"] = @(indexPath.row);
    userInfo[@"theSong"] = _vModel;
    userInfo[@"coverURL"] = [_vModel coverURLForRow:indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"StartPlay" object:nil userInfo:[userInfo copy]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJRecommendViewCell *cell = [[XJRecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJRecommendViewCell"];
    [cell.coverIcon sd_setImageWithURL:[_vModel coverMiddleForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
    cell.titleLabel.text = [_vModel titleForRow:indexPath.row];
    cell.introLabel.text = [_vModel nicknameRorRow:indexPath.row];
    cell.playCountLabel.text = [_vModel playTimesForRow:indexPath.row];
    cell.albumRankLabel.text = @"123";

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_vModel deleFavouriteOrHistorySong:self.sourceType atIndexPatRow:indexPath.row];

//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
