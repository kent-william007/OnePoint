//
//  XJSuperViewController.m
//  music
//
//  Created by kent on 2017/9/14.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJSuperViewController.h"
#import "AppDelegate.h"
#import "XJNetManager.h"

@interface XJSuperViewController()
@property(nonatomic,strong)UIImageView *loadImageV;
@end

@implementation XJSuperViewController{
    BOOL startLoad;
}


- (void)viewDidLoad{
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (startLoad) {
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        [delegate.window addSubview:self.loadImageV];
//        startLoad = NO;
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self dismissLoadingView];
    [XJNetManager cancelTask];
}

- (void)transitionAnimation{
    [self.view startTransitionAnimation];
}

- (UIImageView *)loadImageV{
    if (!_loadImageV) {
        UIImageView *loadImageV = [[UIImageView alloc]init];
        loadImageV.image = [UIImage imageNamed:@"music_tuijian"];
        loadImageV.center = self.view.center;
        loadImageV.bounds = CGRectMake(0, 0, 50, 50);
        [loadImageV startRotationAnimationDuration:1.2];
        //动画
//        CABasicAnimation* rotationAnimation;
//        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//        rotationAnimation.duration = 1.2;
//        rotationAnimation.cumulative = YES;
//        rotationAnimation.repeatCount = ULLONG_MAX;
//        [loadImageV.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        _loadImageV = loadImageV;
    }
    return _loadImageV;
}

- (void)startLoading{
    startLoad = YES;
}

- (void)dismissLoadingView{
    if (_loadImageV) {
//        [_loadImageV.layer removeAllAnimations];
        [_loadImageV removeFromSuperview];
        _loadImageV = nil;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"------内存泄漏检测---%@---dealloc---",[self class]);
}

@end
