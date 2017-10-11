//
//  XJProgressView.m
//  music
//
//  Created by kent on 2017/9/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJProgressView.h"

static UIView *_bgView = nil;
static UIImageView *_loadingView;
static UILabel *_messageLab;
@implementation XJProgressView



+ (void)show{
    [self showMessage:nil];
}

+ (void)showMessage:(NSString *)message{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat s_width = [UIScreen mainScreen].bounds.size.width;
        CGFloat s_height = [UIScreen mainScreen].bounds.size.height;

        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,s_width, s_height)];

        UIImageView *loadingView = [[UIImageView alloc]init];
        loadingView.image = [UIImage imageNamed:@"loading"];
        loadingView.center = CGPointMake(s_width/2.0-25, s_height/2.0-50);
        loadingView.size = CGSizeMake(50, 50);
        _loadingView= loadingView;
        loadingView.tag = 1099;
        [_bgView addSubview:loadingView];
//        _bgView.backgroundColor = [UIColor blackColor];
//        _bgView.alpha = 0.1;
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, s_height/2.0, s_width, 50)];
        [_bgView addSubview:messageLab];
        messageLab.font = [UIFont systemFontOfSize:12];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.textColor = [UIColor lightGrayColor];
        
        _messageLab = messageLab;
    });
    
//    UIWindow *keyWindon = [[UIApplication sharedApplication].windows objectAtIndex:0];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
//    UIView *keyWindon = [self topViewController].view;
    if (![window.subviews containsObject:_bgView]) {
        [window addSubview:_bgView];
        [_loadingView startRotationAnimationDuration:1.2];
        _loadingView.alpha = 1.0;
        _messageLab.alpha = 1.0;
        _messageLab.text = message;
    }
}

+ (void)dismiss{
    if (_bgView) {
        [UIView animateWithDuration:0.5 animations:^{
            _loadingView.alpha = 0.0;
            _messageLab.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_bgView removeFromSuperview];
        }];
      
    }
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    [resultVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"childViewControllers:%@",obj);
        NSLog(@"obj.view.window:%@",obj.view.window);
        if ([obj.view.window isKeyWindow]) {
            NSLog(@"keyWindow----:%@",obj);
        }
        
    }];
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
