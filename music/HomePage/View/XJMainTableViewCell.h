//
//  XJMainTableViewCell.h
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJMainTableViewDelegate <NSObject>

- (void)mainTableViewDidClick:(NSInteger)tag;

@end
typedef void(^buttonClickBlock)(NSInteger *m_index);

@interface XJMainTableViewCell : UITableViewCell
@property(nonatomic,assign)id<XJMainTableViewDelegate> delegate;
@property(nonatomic,strong)UIImageView *coverIV;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,assign)NSInteger tagInt;
@property(nonatomic)BOOL isPlay;
- (void)buttonClickBlock:(buttonClickBlock)clickBlock;
@end
