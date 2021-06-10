//
//  AppDelegate.m
//  baseProject
//
//  Created by FL S on 2017/7/22.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AFNetworkReachabilityManager.h>
#import "SSlanguageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///全局设置
    [self globalApperance];
    ///监听网络环境
//    [self getNetworkStatus];
    ///rootVC
    [self showRoot];
    
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
        _tabbarController = [[SStabbarController alloc] init];
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

//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
//    ///微信新版sdk,微信授权登录必须在此方法中加入下面一行代码
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self.loginDelegate];
//}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [self handleURL:url];
    
    return YES;
}

- (void) handleURL:(NSURL*)url {
    SSLog(@"---------handleUrl = %@",url);
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳到支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
////            SSLog(@"------支付宝--result = %@",resultDic);
//            [[YQpayManager sharePayManager] aliPayResult:resultDic];
//        }];
//    }
    NSRange range = [url.absoluteString rangeOfString:[NSString stringWithFormat:@"%@://pay",Weichat_appid]];
//    if (range.location != NSNotFound) {
//        [WXApi handleOpenURL:url delegate:[YQpayManager sharePayManager]];
//    }
    range = [url.absoluteString rangeOfString:[NSString stringWithFormat:@"%@://platformId=wechat",Weichat_appid]];
    if(range.location != NSNotFound){
//        [WXApi handleOpenURL:url delegate:[SSshareManager sharemanager]];
    }
    range = [url.absoluteString rangeOfString:[NSString stringWithFormat:@"%@://oauth",Weichat_appid]];
    if(range.location != NSNotFound){
        if (_loginDelegate) {
//            [WXApi handleOpenURL:url delegate:self.loginDelegate];
            self.loginDelegate = nil;
        }
    }
    
//    range = [url.absoluteString rangeOfString:[NSString stringWithFormat:@"%@://",@"QQ060C526E"]];
//    if (range.location != NSNotFound) {
//        [QQApiInterface handleOpenURL:url delegate:self];
//    }
    
//    if ([url.absoluteString rangeOfString:yiqiScheme].location != NSNotFound){  //驿起本地操作
//
//        [SShelper toSchemeUrl:url];
//    }
}

///监听网络状态
- (void)getNetworkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatus = status;
    }];
}

///关闭网络状态的监听
- (void)stopNetworkStatus {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

///切换设置语言
- (void)setAppLanguage:(NSString*)language {
    [SSlanguageManager SSsetLanguage:language];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"appLanguage"];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[SStabbarController alloc] init];
}


@end
