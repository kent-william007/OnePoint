//
//  XJMainViewController.m
//  music
//
//  Created by kent on 2017/8/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMainViewController.h"
#import "NewContentViewModel.h"
#import "XJMainTableViewCell.h"
#import "XJPLayManager.h"
#import "TracksViewModel.h"


@interface XJMainViewController ()<UITableViewDelegate,UITableViewDataSource,XJMainTableViewDelegate>
@property(nonatomic,strong)NewContentViewModel *contentVM;
@property(nonatomic,strong)UITableView *mainTableView;
@end

@implementation XJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self initMainTableView];
   [self.contentVM getDataCompletionHandle:^(NSError *error) {
       [self.mainTableView reloadData];
   }];
}

- (void)initMainTableView{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[XJMainTableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contentVM rowNumber];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.width * 1.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XJMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"];
    if (!cell) {
        cell = [[XJMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainTableViewCell"];
    }
    [cell.coverIV sd_setImageWithURL:[self.contentVM coverURLForRow:indexPath.section] placeholderImage:[UIImage imageNamed:@"launchImage"]];
    cell.tagInt = indexPath.section;
    cell.titleLb.text = [self.contentVM trackTitleForRow:indexPath.section];
    cell.delegate = self;
   [cell buttonClickBlock:^(NSInteger *m_index) {
       NSLog(@"%li",(long)m_index);
   }];
    
    return cell;
}

- (void)mainTableViewDidClick:(NSInteger)tag{
    
    TracksViewModel *tracksVM = [[TracksViewModel alloc]initWithAlbumId:[self.contentVM albumIdForRow:tag] title:[self.contentVM titleForRow:tag] isAsc:YES];
    
    [tracksVM getItemModelData:^(NSError *error) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"musicURL"] = [tracksVM playURLForRow:tag];
        userInfo[@"indexPathRow"] = @(tag);
        userInfo[@"theSong"] = tracksVM;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StartPlay" object:nil userInfo:[userInfo copy]];
    }];
}

- (NewContentViewModel *)contentVM{
    if (!_contentVM) {
        _contentVM = [[NewContentViewModel alloc]init];
    }
    return _contentVM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
