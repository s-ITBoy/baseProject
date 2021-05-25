//
//  AppDelegate.h
//  baseProject
//
//  Created by FL S on 2017/7/22.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SStabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) SStabbarController* tabbarController;

///网络状态 -1:未检测；0：无网络；1：手机流量；2：wifi 状态
@property(nonatomic,assign) NSInteger networkStatus;

///第三方登录回调使用
@property(nonatomic,weak) id loginDelegate;

- (void)showRootVC;

///切换设置语言
- (void)setAppLanguage:(NSString*)language;

@end

