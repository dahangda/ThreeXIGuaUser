//
//  AppDelegate.m
//  hbbc
//
//  Created by mac on 2016/10/19.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AFNetworking.h"
#import "Config.h"

@interface AppDelegate ()
{
    AFNetworkReachabilityStatus net_status;
}

@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) NSTimer *timer;//定时器
@property (nonatomic, strong) UIImageView *loadingImageView;//加载图片视图

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self checkOnNetWorkingStatus];
    [self startCreateUI];
    
    return YES;
}
/**开始创建UI界面*/
- (void)startCreateUI {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _mainVC = [[MainViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:_mainVC];
    naviVC.navigationBar.barTintColor = SYSTERMCOLOR;
    self.window.rootViewController = naviVC;
    
    [self.window makeKeyAndVisible];
    
}
/**检测网络状态*/
- (void)checkOnNetWorkingStatus {
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //开启网络监视器；
    [afNetworkReachabilityManager startMonitoring];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        net_status = status;
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"蒲公英戒毒提醒您" message:@"当前没有网络连接..."  delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
