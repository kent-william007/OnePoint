//
//  XJTabBarController.m
//  music
//
//  Created by kent on 2017/8/12.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJTabBarController.h"
#import "XJMainViewController.h"
#import "XJMiddleViewController.h"
#import "XJPlayTabbar.h"
#import "XJPlayView.h"
#import "XJPLayManager.h"
#import "XJMainPlayController.h"


@interface XJTabBarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)XJPlayView *player;
@end

@implementation XJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
    [self hideTabBarTopLine];
}

- (void)initTabBar{
    
    XJMainViewController *mainVC = [[XJMainViewController alloc]init];
    [self controller:mainVC title:@"主页" image:@"tab_icon_selection_normal" selectImage:@"tab_icon_selection_highlight"];
    
    XJMiddleViewController *recommendVC = [[XJMiddleViewController alloc]init];
    [self controller:recommendVC title:@"推荐" image:@"icon_tab_shouye_normal" selectImage:@"icon_tab_shouye_highlight"];
    
    XJMiddleViewController *recommendVC1 = [[XJMiddleViewController alloc]init];
    [self controller:recommendVC1 title:@"推荐" image:@"" selectImage:@""];

    XJPlayView *player = [[XJPlayView alloc]init];
    player.backgroundColor = [UIColor clearColor];
    [self.view addSubview:player];
    [player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.equalTo(self.view);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width/3));
        make.height.equalTo(@70);
    }];
    _player = player;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self addNotification];
}
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playingInfoDictionary:) name:@"StartPlay" object:nil];
}
- (void)playingInfoDictionary:(NSNotification *)notification{
   XJPLayManager *playmanager = [XJPLayManager sharedInstance];
   TracksViewModel *_tracksVM = notification.userInfo[@"theSong"];
   NSInteger  _indexPathRow = [notification.userInfo[@"indexPathRow"] integerValue];
   NSURL *coverURL = notification.userInfo[@"coverURL"];

    [_player.loopImage sd_setImageWithURL:coverURL placeholderImage:[UIImage imageNamed:@"tabbar_np_play"]];
    [_player setPlayButtonView];
    [_player touchPlayButton:^{
        XJMainPlayController *playVC = [[XJMainPlayController alloc]init];
        playVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:playVC animated:YES completion:nil];
    }];
    [playmanager playWithModel:_tracksVM indexPathRow:_indexPathRow];
}
- (void)controller:(UIViewController *)itemVC title:(NSString *)title image:(NSString *)imageName selectImage:(NSString *)selectImageName{
    if (![imageName isEqualToString:@""]) {
        itemVC.tabBarItem.title = title;
        itemVC.tabBarItem.image = [UIImage imageNamed:imageName];
        itemVC.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:itemVC];
    nav.delegate = self;
    [self addChildViewController:nav];
}

- (void)hideTabBarTopLine{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}


//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    return [[FYMissAnimation alloc]init];
//}
//
//-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    return (_interactiveTransition.isInteracting ? _interactiveTransition : nil);
//}

//- (void)navigationController:(UINavigationController *)navigationController
//      willShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animated{
//    
//    if (viewController.hidesBottomBarWhenPushed) {
//        
//        if(self.tabBar.frame.origin.y == [[UIScreen mainScreen] bounds].size.height - 49){
//            
//            [UIView animateWithDuration:0.2
//                             animations:^{
//                                 CGRect tabFrame = self.tabBar.frame;
//                                 tabFrame.origin.y = [[UIScreen mainScreen] bounds].size.height;
//                                 self.tabBar.frame = tabFrame;
//                             }];
//            self.tabBar.hidden = YES;
//        }
//        //self.playView.hidden = YES;
//        
//    } else {
//        
//    }
//     [super.view bringSubviewToFront:self.player];
//    
//}



- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
//    if (viewController.hidesBottomBarWhenPushed) {
//        
//    } else {
//        
//        if(self.tabBar.frame.origin.y == [[UIScreen mainScreen] bounds].size.height ){
//            
//            [UIView animateWithDuration:0.2
//                             animations:^{
//                                 CGRect tabFrame = self.tabBar.frame;
//                                 tabFrame.origin.y += -49;
//                                 self.tabBar.frame = tabFrame;
//                             }];
//            self.tabBar.hidden = NO;
//            
//        }
//        //self.playView.hidden = YES;
//    }
    [super.view bringSubviewToFront:self.player];
    //NSLog(@"%@",self.playView.superview);
    
}

- (void)hideTabBar {
    self.player.hidden = NO;
}

- (void)showTabBar{
    self.player.hidden = YES;
}
























@end
