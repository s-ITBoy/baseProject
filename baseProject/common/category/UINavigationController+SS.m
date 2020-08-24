//
//  UINavigationController+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UINavigationController+SS.h"

@implementation UINavigationController (SS)
- (void)SSpopViewControllerWithClass:(NSString *)className {
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            [self popToViewController:vc animated:true];
        }
    }
}

@end
