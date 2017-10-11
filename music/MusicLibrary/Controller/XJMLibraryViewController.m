//
//  XJMLibraryViewController.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMLibraryViewController.h"
#import "MoreContentViewModel.h"
#import "XJLibraryCell.h"
#import "XJMLibraryDetailVC.h"

@interface XJMLibraryViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mTableview;
@property(nonatomic,strong)MoreContentViewModel *moreVM;
@property(nonatomic,strong)NSArray *dataSource;

@end
@implementation XJMLibraryViewController
#pragma mark -LIFE CYCLE
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"categoryData" ofType:@"plist"];
    NSMutableArray *categoryArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    _dataSource = [categoryArray copy];

    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initTalbeview];

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
        //        make.top.equalTo(self.view).offset(20);
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];

//    450/180
    _mTableview.delegate = self;
    _mTableview.dataSource = self;
    _mTableview.rowHeight = kScreenW * (180/450.0);
    _mTableview.sectionHeaderHeight = 10;
    [_mTableview registerClass:[XJLibraryCell class] forCellReuseIdentifier:@"XJLibraryCell"];
}



#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.moreVM getDataCompletionHandle:^(NSError *error) {
        XJMLibraryDetailVC *libraryVC = [[XJMLibraryDetailVC alloc]init];
        libraryVC.contentType = [self.moreVM contentListName:indexPath];
        [self.navigationController pushViewController:libraryVC animated:YES];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XJLibraryCell *cell = [[XJLibraryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XJLibraryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell contentForCell:_dataSource[indexPath.section]];
    return cell;
}
- (MoreContentViewModel *)moreVM{
    if (!_moreVM) {
        _moreVM = [[MoreContentViewModel alloc]initWithCategoryId:2 contentType:@"album"];
    }
    return _moreVM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
