//
//  XJShutInTimeCell.h
//  music
//
//  Created by kent on 2017/9/22.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJShutInTimeCell : UITableViewCell
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)UILabel *timeLab;
- (void)setContent:(NSString *)contentTitle;
- (void)setSelectedRow:(BOOL)isSelect;
- (void)selectTimer:(NSString *)timerStr;
@end
