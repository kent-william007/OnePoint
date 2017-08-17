//
//  XJPlayTabbar.m
//  music
//
//  Created by kent on 2017/8/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJPlayTabbar.h"
#import "UIView+Extension.h"
#import "UIButton+EnlargeTouchArea.h"

@interface XJPlayTabbar()
@property (nonatomic,weak)UIButton *plusBtn;
@end
@implementation XJPlayTabbar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        playerBtn.backgroundColor = [UIColor greenColor];
        [playerBtn setImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateNormal];
        [playerBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];

        self.plusBtn = playerBtn;
        [self addSubview:self.plusBtn];
        self.userInteractionEnabled = YES;
        [self hideTabBarTopLine];
    }
    return self;
}

- (void)hideTabBarTopLine{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:img];
    [self setShadowImage:img];
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//}
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    
//}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * can = [super hitTest:point withEvent:event];
    if (point.y>=-40 && point.x>=self.width*2/3) {
        return self.plusBtn;
    }
    return can;
}
- (void)plusClick{
    NSLog(@"plus");
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat tabbarButtonW = self.width/3.0;
    CGFloat height = self.height;
    CGFloat tabbarButtonIndex = 0;
    NSLog(@"%f",self.itemWidth);
       NSLog(@"%f",self.itemSpacing); 
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.backgroundColor = [UIColor greenColor];
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            NSLog(@"---child:%@",child);
            if (tabbarButtonIndex == 0) {
                child.backgroundColor = [UIColor brownColor];
            }else{
                child.backgroundColor = [UIColor blueColor];
            }
            tabbarButtonIndex ++;
        }
    }
    self.plusBtn.x= self.width-tabbarButtonW;
    self.plusBtn.y = -40;
    self.plusBtn.width = tabbarButtonW;
    self.plusBtn.height = height+40;

    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"subview:%@",obj);
    }];
    self.plusBtn.imageEdgeInsets = UIEdgeInsetsMake(-40, 70, -40, 0);

}
@end
