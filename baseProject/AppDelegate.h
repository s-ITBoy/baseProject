//
//  AppDelegate.h
//  baseProject
//
//  Created by FL S on 2019/7/22.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SStabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) SStabbarController* tabbarController;
///第三方登录回调使用
@property(nonatomic,weak) id loginDelegate;

- (void)showRootVC;

@end

