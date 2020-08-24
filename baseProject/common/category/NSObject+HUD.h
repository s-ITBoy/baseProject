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

-(void)presentMessageTips_:(NSString *)message;

- (void)presentMessageTips_:(NSString *)message dismisblock:(void(^)(void))dismissblock;

-(void)presentMessageTips:(NSString *)message;
- (void)presentMessageTips:(NSString *)message dismisblock:(void(^)(void))dismissblock;
- (void)presentMessageTips_:(NSString *)message duration:(CGFloat)duration dismisblock:(void(^)(void))dismissblock;
-(MBProgressHUD *)presentLoadingTips:(NSString *)message;
-(void)dismissTips;
-(void)presentFailureTips:(NSString *)message;
-(void)presentLoadinghud;
-(void)dismissAllTips;

@end

NS_ASSUME_NONNULL_END
