//
//  XJShutInTime.m
//  music
//
//  Created by kent on 2017/9/21.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJShutInTime.h"
#import "XJShutInTimeCell.h"
#import "NSTimer+EOCBlocksSupport.h"
#import "XJCountTimer.h"


@interface XJShutInTime()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mTablview;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)XJShutInTimeCell *selectCell;
@end

NSArray *timeArray;
static CGFloat cellHeight = 50;
static CGFloat footerHeight = 45;
static NSString *cell_id = @"XJShutInTimeCell_id";

@implementation XJShutInTime{
    CGFloat tableViewHeight;
    NSArray *timeArray;
    NSTimer *_mtimer;
    NSInteger _totalTime;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor lightGrayColor];
        tableViewHeight = kScreenH*0.5;
        self.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
        timeArray = @[@"不启用",@"1分钟",@"20分钟",@"30分钟",@"40分钟",@"50分钟",@"60分钟",@"70分钟",@"80分钟",@"90分钟"];
        self.mTablview.delegate = self;
        self.mTablview.dataSource = self;
        //默认不选
        _selectIndex = -1;

    }
    return self;
}
- (void)dissmiss{
    [_mTablview mas_remakeConstraints:^(MASConstraintMaker *make){
        make.leading.trailing.equalTo(_mTablview.superview);
        make.top.equalTo(_mTablview.superview).offset(kScreenH);
        make.height.mas_equalTo(tableViewHeight);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.mTablview.superview layoutIfNeeded];
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_mTablview  removeFromSuperview];
        _mTablview = nil;
        [self removeFromSuperview];
    }];
}

- (void)show{

    [self.mTablview.superview layoutIfNeeded];
    [self.mTablview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mTablview.superview).offset(tableViewHeight);
    }];

    [UIView animateWithDuration:0.3 animations:^{
        [self.mTablview.superview layoutIfNeeded];
        self.alpha = 0.5;
    }];

}

- (UITableView *)mTablview{
    if (!_mTablview) {
       
        UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
        [keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview);
        }];

         _mTablview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [keyWindow addSubview:_mTablview];
        _mTablview.showsVerticalScrollIndicator = NO;
        _mTablview.backgroundColor = [UIColor whiteColor];
        [_mTablview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(_mTablview.superview);
            make.top.equalTo(_mTablview.superview).offset(kScreenH);
            make.height.mas_equalTo(tableViewHeight);
        }];
//        [_mTablview registerClass:[XJShutInTimeCell class] forCellReuseIdentifier:cell_id];
    }
    return _mTablview;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *footer = [UIButton  buttonWithType:UIButtonTypeCustom];
    footer.frame = CGRectMake(0, 0, kScreenW, footerHeight);
    footer.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    [footer setTitle:@"关闭" forState: UIControlStateNormal];
    [footer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footer addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (indexPath.row == _selectIndex) return;
     _selectIndex = indexPath.row;
    //刷新列表
    [_mTablview reloadData];

    XJShutInTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectTimer:timeArray[indexPath.row]];
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return timeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消重用机制，每个cell都有一个唯一的ID
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    XJShutInTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[XJShutInTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setContent:timeArray[indexPath.row]];
    if (indexPath.row == _selectIndex) {
        [cell setSelectedRow:YES];
    }else{
        [cell setSelectedRow:NO];
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat setY = cellHeight * timeArray.count - tableViewHeight + footerHeight;
    if(scrollView.contentOffset.y > setY ){
        CGPoint point = CGPointMake(0, setY);
        scrollView.contentOffset = point;
    }
}
@end
