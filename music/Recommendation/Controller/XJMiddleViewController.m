//
//  XJMiddleViewController.m
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJMiddleViewController.h"
#import "XJMyViewController.h"//我的
#import "XJRecommendViewController.h"//推荐
#import "XJMLibraryViewController.h"//乐库
#import "XJNavigaterView.h"
#import "XJBGCollectionViewCell.h"

static NSString *cellID = @"XJBGCollectionViewCell";

#define collectionWidth  [UIScreen mainScreen].bounds.size.width
#define collectionHeight [UIScreen mainScreen].bounds.size.height

@interface XJMiddleViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XJNavigaterViewDelegate>
@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)XJNavigaterView *titleView;
@property(nonatomic,assign)BOOL isFirst;
@end

@implementation XJMiddleViewController{
    NSArray *childViewcontrollers;
    BOOL didEndDisplay;
}

#pragma mark -LIFE CYCLE
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    _isFirst = YES;
    self.view.backgroundColor = [UIColor clearColor];
    UIView *uivew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    uivew.backgroundColor = [UIColor clearColor];
    XJNavigaterView *titleView = [[XJNavigaterView alloc]initWithTitles:@[@"我的",@"推荐",@"乐库"]];
    titleView.delegate = self;
    _titleView = titleView;
    self.navigationItem.titleView = _titleView;
    
    [self initChilderViewcontroller];
    [self initMainCollectionView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //首次进入，显示中间项
    if (_isFirst) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.childViewControllers.count/2 inSection:0];
        [_mainCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
        [_titleView setSelecButtonIndex:self.childViewControllers.count/2];
        _isFirst = NO;
        
    }
}

#pragma mark -分别把-我的-推荐-乐库-对应的控制添加到MiddleVC。
- (void)initChilderViewcontroller{
    
    XJMyViewController *myVC = [[XJMyViewController alloc]init];
    [self addChildViewController:myVC];
    
    XJRecommendViewController *recommendVC = [[XJRecommendViewController alloc]init];
    [self addChildViewController:recommendVC];

    XJMLibraryViewController *mLibraryVC = [[XJMLibraryViewController alloc]init];
    [self addChildViewController:mLibraryVC];
}

#pragma mark -分别把-我的-推荐-乐库-对应的View添加到MiddleVC的collectionView
- (void)initMainCollectionView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;//横向布局
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    collectionV.backgroundColor = [UIColor clearColor];
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.contentSize = CGSizeMake(collectionWidth * 3, collectionHeight);
    collectionV.pagingEnabled = YES;
    collectionV.alwaysBounceHorizontal = YES;
    [collectionV registerClass:[XJBGCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionV];
    collectionV.delegate = self;
    collectionV.dataSource =self;
    _mainCollectionView = collectionV;
    [collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.leading.equalTo(self.view);
        make.height.mas_equalTo(collectionHeight);
        make.width.mas_equalTo(collectionWidth);
    }];
    collectionV.bounces = NO;
    
}

#pragma mark -cellectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionWidth,collectionHeight);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XJBGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (![cell.contentView.subviews containsObject:self.childViewControllers[indexPath.row].view]) {
        NSLog(@"%@",self.childViewControllers[indexPath.row]);
        [cell.contentView addSubview:self.childViewControllers[indexPath.row].view];
    }
    return cell;
}

#pragma mark -头部按钮点击
- (void)navigaterViewclickIndex:(NSInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_mainCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
}
#pragma mark -左右滚动collectionCell
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/collectionWidth;
    [_titleView setSelecButtonIndex:index];
}
@end
