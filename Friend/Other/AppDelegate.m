//
//  AppDelegate.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PasswordViewController.h"
#import "CustomNavigationController.h"
//#import "UIMarginViewController/UIMarginViewController.h"
@interface AppDelegate ()
@property (assign, nonatomic) UIBackgroundTaskIdentifier bgTaskId;            // 后台任务标记
@property (strong, nonatomic) dispatch_block_t expirationHandler;
@property (assign, nonatomic) BOOL background;
@property (assign, nonatomic) BOOL isLogined;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // set RootViewController
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    CustomNavigationController *customVC = [[CustomNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    self.window.rootViewController = customVC;
    [self.window makeKeyAndVisible];
    
    UIApplication* app = [UIApplication sharedApplication];
    // 数据模拟
    self.isLogined = YES;
    
    __weak AppDelegate* weakSelf = self;
    
    // 创建后台自唤醒，当180s时间结束的时候系统会调用这里面的方法
    self.expirationHandler = ^{
        [app endBackgroundTask:weakSelf.bgTaskId];
        weakSelf.bgTaskId = UIBackgroundTaskInvalid;
        NSLog(@"Expired，处理超时。。。。。");
        CustomNavigationController *customVC = [[CustomNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
        self.window.rootViewController = customVC;
    };

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 当登陆状态才启动后台操作
    if (self.isLogined)
    {
        NSLog(@"Entered background");
        self.bgTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:self.expirationHandler];
        self.background = YES;
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.background = NO;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
