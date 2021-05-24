//
//  UIViewController+SS.h
//  baseProject
//
//  Created by F S on 2017/7/10.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SS)

#pragma mark --------- 跳转 ----------
//push
- (void)SS_pushVCWithClassStr:(NSString*_Nullable)classStr withPropertyDic:(NSDictionary*_Nullable)dic;

//present
- (void)SS_presentVCWithClassStr:(NSString*_Nullable)classStr withPropertyDic:(NSDictionary*_Nullable)dic;

@end

NS_ASSUME_NONNULL_END
