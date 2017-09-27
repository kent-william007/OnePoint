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
#import "XJPlayView.h"
#import "XJPLayManager.h"
#import "XJMainPlayController.h"
#import "XJTabBar.h"
#import "UIView+Animations.h"
#import "FYMissAnimation.h"
#import "FYPercentDrivenInteractiveTransition.h"



@interface XJTabBarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate,UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)XJPlayView *player;
@property(nonatomic,strong)FYPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation XJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTabBar];
    [self hideTabBarTopLine];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_player startLoopTransitionAnimation];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player stopRotationAnimation];
}


#pragma mark -初始化TABBAR
- (void)initTabBar{
    
    XJMainViewController *mainVC = [[XJMainViewController alloc]init];
    [self controller:mainVC title:@"主页" image:@"tab_icon_selection_normal" selectImage:@"tab_icon_selection_highlight"];
    
    XJMiddleViewController *recommendVC1 = [[XJMiddleViewController alloc]init];
    [self controller:recommendVC1 title:@"推荐" image:@"" selectImage:@""];

    
    XJMiddleViewController *recommendVC = [[XJMiddleViewController alloc]init];
    [self controller:recommendVC title:@"推荐" image:@"icon_tab_shouye_normal" selectImage:@"icon_tab_shouye_highlight"];
    

    XJPlayView *player = [XJPlayView shareInstance];
    player.backgroundColor = [UIColor clearColor];
    [self.view addSubview:player];
    [player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(player.superview);
        make.centerX.equalTo(player.superview);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width/3));
        make.height.equalTo(@70);
    }];
//    self.tabBar.hidden = YES;
    
//    XJTabBar *tabBar = [[XJTabBar alloc]init];
//    tabBar.tabBardelegate = self;
//    [self setValue:tabBar forKey:@"tabBar"];
    _player = player;
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self addNotification];
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


- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
    if (navigationController.viewControllers[0] == viewController) {
        if(self.tabBar.frame.origin.y != [[UIScreen mainScreen] bounds].size.height - 49){
            [UIView animateWithDuration:0.2
                             animations:^{
                        CGRect tabFrame = self.tabBar.frame;
                     tabFrame.origin.y += -49;
                      self.tabBar.frame = tabFrame;
            }];
        }
    }else{
        if(self.tabBar.frame.origin.y == [[UIScreen mainScreen] bounds].size.height - 49){
            [UIView animateWithDuration:0.8
                             animations:^{
                        CGRect tabFrame = self.tabBar.frame;
                      tabFrame.origin.y = [[UIScreen mainScreen] bounds].size.height;
                      self.tabBar.frame = tabFrame;
            }];
        }
    }
}


#pragma mark -隐藏TabBar上面的线
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

#pragma mark -添加播放音乐的通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playingInfoDictionary:) name:@"StartPlay" object:nil];
}

- (void)playingInfoDictionary:(NSNotification *)notification{
   XJPLayManager *playmanager = [XJPLayManager sharedInstance];
   TracksViewModel *_tracksVM = notification.userInfo[@"theSong"];
   NSInteger  _indexPathRow = [notification.userInfo[@"indexPathRow"] integerValue];
   NSURL *coverURL = notification.userInfo[@"coverURL"];
  [_player setLoopImageUrl:coverURL];
//    [_player.loopImage stopRotationAnimation];
//    [_player.loopImage sd_setImageWithURL:coverURL placeholderImage:[UIImage imageNamed:@"launchImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        [_player.loopImage startTransitionAnimation];
//        [_player.loopImage startRotationAnimationDuration:2.0];
//    }];
    [_player setPlayButtonView];
    [_player touchPlayButton:^{
        XJMainPlayController *playVC = [[XJMainPlayController alloc]init];
        playVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:playVC animated:YES completion:nil];
    }];
    [playmanager playWithModel:_tracksVM indexPathRow:_indexPathRow];
}


#pragma mark -UIResponder-锁屏控制／播放／暂停／上一曲／下一曲
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlNextTrack:
                [[XJPLayManager sharedInstance] nextSong];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [[XJPLayManager sharedInstance]preSong];
                break;
            case  UIEventSubtypeRemoteControlPause:
                [[XJPLayManager sharedInstance] pauseMusic];
                break;
            case  UIEventSubtypeRemoteControlPlay:
                [[XJPLayManager sharedInstance] pauseMusic];
                break;
            default:
                break;
                
        }
    }
}

@end
