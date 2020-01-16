//
//  AppDelegate.m
//  baseProject
//
//  Created by FL S on 2019/7/22.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self showRoot];
    [self globalApperance];
    
    return YES;
}

- (void)showRoot {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self showRootVC];
    [self.window makeKeyAndVisible];
}

- (void)showRootVC {
    self.tabbarController = nil;
    self.window.rootViewController = self.tabbarController;
}

- (SStabbarController *)tabbarController {
    if (!_tabbarController) {
        _tabbarController = [SStabbarController new];
    }
    return _tabbarController;
}

/// 全局修改导航栏样式 UITableView分割线样式 导航栏按钮样式
- (void)globalApperance{
    //    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:THEMECOLOR size:CGSizeMake(SCREENWIDTH, 1)]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor SScolorWithHexString:@"#1A1A1A"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor SStitleColor51],NSFontAttributeName:[UIFont SSCustomFont16]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor SScolorWithR:110 G:110 B:110]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor SScolorWithHexString:@"#555555"],NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor SScolorWithHexString:@"#FF716E"],NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
