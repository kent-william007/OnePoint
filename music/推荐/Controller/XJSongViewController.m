//
//  XJSongViewController.m
//  music
//
//  Created by kent on 2017/8/27.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJSongViewController.h"
#import "TracksViewModel.h"
#import "XJSongHeaderView.h"
#import "XJSongCell.h"
#import "XJMainPlayController.h"

@interface XJSongViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger albumId;
@property(nonatomic,copy)NSString *mtitle;
@property(nonatomic,strong)TracksViewModel *model;

@property(nonatomic,strong)UITableView *mTableview;
@property(nonatomic,strong)UIView *m_tableHeaderView;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)XJSongHeaderView *headerView;

// 升序降序标签: 默认升序
@property (nonatomic,assign) BOOL isAsc;
@end


@implementation XJSongViewController{
    CGFloat contentOfSet;
}

- (instancetype)initWithAlbumId:(NSInteger )albumId title:(NSString *)title{
    if (self = [super init]) {
        _albumId = albumId;
        _mtitle = title;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)initUI{
    
    contentOfSet = kScreenW * 0.6;
    
    self.view.backgroundColor = [UIColor redColor];
    _mTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20) style:UITableViewStylePlain];
    [self.view addSubview:_mTableview];

    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.contentInset = UIEdgeInsetsMake(contentOfSet, 0,0, 0);
    [_mTableview registerClass:[XJSongCell class] forCellReuseIdentifier:@"XJSongCell"];
    
    _headerView = [[XJSongHeaderView alloc]initWithFrame:CGRectMake(0, -contentOfSet,[UIScreen mainScreen].bounds.size.width, contentOfSet)];
    
    __weak __typeof__(self) weakSelf = self;
    [_headerView clickBackBun:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [_headerView clickMenuBun:^{
        NSLog(@"clickMenuBun");
    }];

    

    [_mTableview addSubview:_headerView];
}

- (void)loadData{
    
    [self.model getDataCompletionHandle:^(NSError *error) {
        [_mTableview reloadData];
//        [_headerView.bgImageView sd_setImageWithURL:[self.model mCoverLarge]
//                                   placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
//        _headerView.navTitle.text = [self.model mTitle];
//        [_headerView.mCoverLargeImageView sd_setImageWithURL:[self.model mCoverLarge]
//                                   placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
//        [_headerView.avatarImageView sd_setImageWithURL:[self.model avatarPath]
//                                            placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
//        _headerView.playTimesLabel.text = [self.model playTimes];
//        _headerView.nicknameLabel.text = [self.model nickname];
//        _headerView.shortIntroLabel.text = [self.model shortIntro];
//        _headerView.tagsLabel.text = [self.model tags];
        [_headerView setContent:self.model];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model rowNumber];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.model getDataCompletionHandle:^(NSError *error) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"musicURL"] = [_model playURLForRow:indexPath.row];
        userInfo[@"indexPathRow"] = @(indexPath.row);
        userInfo[@"theSong"] = _model;
        userInfo[@"coverURL"] = [_model coverURLForRow:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StartPlay" object:nil userInfo:[userInfo copy]];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XJSongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XJSongCell"];
    
    [cell.coverMiddleImageView sd_setImageWithURL:[self.model coverMiddleForRow:indexPath.row]];
    cell.titleLabel.text = [self.model titleForRow:indexPath.row];
    cell.nicknameLabel.text = [self.model authorRorRow:indexPath.row];
    cell.createdAtLabel.text = [self.model createAtForRow:indexPath.row];
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //初始化这个页面的时候，scrollView的contentOffset.y
    //就已经偏移量-contentOfSet的距离
    if (scrollView.contentOffset.y >= -contentOfSet) {
        return;
    }
    //纵向放大
    _headerView.y = 20+ scrollView.contentOffset.y;
    _headerView.height = - scrollView.contentOffset.y;
    //横向放大
    //_imageV.width = [UIScreen mainScreen].bounds.size.width/100.0 * _imageV.height;
    //_imageV.centerX = self.view.centerX;
    
    NSLog(@"%f",_headerView.y);

}
- (TracksViewModel *)model{
    if (!_model) {
        _model = [[TracksViewModel alloc]initWithAlbumId:_albumId title:_mtitle isAsc:!_isAsc];
    }
    return _model;
}

@end
