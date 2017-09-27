//
//  XJNavigaterView.h
//  music
//
//  Created by kent on 2017/8/19.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJNavigaterViewDelegate<NSObject>
@optional
- (void)navigaterViewclickIndex:(NSInteger)index;
@end

@interface XJNavigaterView : UIView
@property(nonatomic,weak)id<XJNavigaterViewDelegate> delegate;

- (instancetype)initWithTitles:(NSArray *)titleArray;
- (void)setSelecButtonIndex:(NSInteger)index;
@end
