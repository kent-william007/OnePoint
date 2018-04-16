//
//  XJNavigationController.m
//  music
//
//  Created by kent on 2017/9/16.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJNavigationController.h"
@interface XJNavigationController()<UIGestureRecognizerDelegate>
@end

@implementation XJNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
    //使用全屏滑动带起左边缘滑动
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGesture];
    panGesture.delegate = self;
//    UIScreenEdgePanGestureRecognizer *edPan = self.interactivePopGestureRecognizer;
//    edPan.edges = UIRectEdgeAll;
//    //控制手势触发
    self.interactivePopGestureRecognizer.enabled = NO;
    


}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    NSLog(@"%@",viewController);
}
- (void)back{
    
}
#pragma mark -判断是否响应右滑返回
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //如果现在处于根控制器，那么就不需要右滑返回
    return self.viewControllers.count > 1;
}

@end
