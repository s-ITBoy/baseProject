//
//  NSObject+HUD.h
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HUD)<MBProgressHUDDelegate>

#pragma mark --------- 自定义 SSshowMsg -------------
- (void)SSshowCustomWithMsg:(NSString*)msg;

- (void)SSshowCustomWithMsg:(NSString*)msg dismissBlock:(void (^)(void))disBlock;

#pragma mark --------- 自定义 HUD（网络请求时的加载菊花） -----------
- (void)SSpresentLoading;

- (void)SSdimissLoading;

- (void)SSdimissAllLoading;


#pragma mark --------- HUD ------------- 
-(void)presentMessageTips:(NSString*)message;

- (void)presentMessageTips:(NSString*)message dismisblock:(void(^)(void))dismissblock;

- (void)presentMessageTips_:(NSString*)message duration:(CGFloat)duration dismisblock:(void(^)(void))dismissblock;

-(MBProgressHUD*)presentLoadingTips:(NSString*)message;

-(void)presentLoadinghud;

-(void)dismissAllTips;

-(void)dismissTips;

@end

NS_ASSUME_NONNULL_END
