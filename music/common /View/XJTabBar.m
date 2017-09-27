//
//  XJTabBar.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJTabBar.h"
@interface XJTabBar()
@property (nonatomic,weak)UIButton *plusBtn;
@end

@implementation XJTabBar{
    UIView *_middleView;
}
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        UIButton *plusBtn = [[UIButton alloc] init];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusBtn.size = plusBtn.currentBackgroundImage.size;
//        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:plusBtn];
//        self.plusBtn = plusBtn;
//    }
//    return self;
//}
- (instancetype)initWithMiddleView:(UIView *)middleView{
    if (self = [super init]) {
        _middleView = middleView;
        [self addSubview:_middleView];
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void)plusClick
{
    if ([self.tabBardelegate respondsToSelector:@selector(clickPlusButtonDelegate:)]) {
        [self.tabBardelegate clickPlusButtonDelegate:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _middleView.centerX= self.width * 0.5;
    _middleView.centerY = self.height * 0.5;
    CGFloat tabbarButtonW = self.width/3;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 1) {
                tabbarButtonIndex++;
            }
        }
    }
}

@end
