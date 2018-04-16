//
//  AppDelegate.m
//  music
//
//  Created by kent on 2017/8/11.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "AppDelegate.h"
#import "XJTabBarController.h"
#import "XJPLayManager.h"
#import "UncaughtExceptionHandler.h"
#import "XJPlayView.h"
#import <BmobSDK/Bmob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bmob registerWithAppKey:@"9282898b959b8b3790b48266568ca8bc"];
    [UncaughtExceptionHandler installUncaughtExceptionHandler:YES showAlert:YES];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[XJTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
    NSString * className = @"Found";
    
    BmobObject *obj = [[BmobObject alloc] initWithClassName:className];
    
    [obj setObject:@"你好" forKey:@"title"];
    [obj setObject:@"13631524989" forKey:@"phone"];
    [obj setObject:@"黑色iphone6" forKey:@"describe"];
    
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            NSLog(@"提交成功");
            //[self performSelector:@selector(goback) withObject:nil afterDelay:0.7f];
        }else{
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                                message:[[error userInfo] objectForKey:@"error"]
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"ok", nil];
            [alertview show];
        }
        
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *className = @"";
        
        //    if (_isFound) {
        //        className = @"Found";
        //    }else
        className = @"Found";
        
//        BmobQuery *query = [BmobQuery queryWithClassName:className];
//        [query orderByDescending:@"updatedAt"];
//        query.limit = 20;
//        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//            
//            for (BmobObject *obj in array) {
//                NSLog(@"%@",obj);
//            }
//        }];
        

    });
    
    BmobQuery *queryCheck = [BmobQuery queryWithClassName:@"CheckVersion"];
    [queryCheck orderByDescending:@"updatedAt"];
    queryCheck.limit = 20;
    [queryCheck findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(error){
            NSLog(@"erroo_:%@",error);
        }
        for (BmobObject *obj in array) {
            NSLog(@"%@",obj);
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[XJPlayView shareInstance] startLoopTransitionAnimation];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[XJPlayView shareInstance] startLoopTransitionAnimation];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
