//
//  SStiming.h
//  baseProject
//
//  Created by F S on 2020/12/22.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SStimeKey_sendCode       @"sendCode"     //发送验证码

NS_ASSUME_NONNULL_BEGIN
///倒计时
@interface SStiming : NSObject

/**
 *  开启倒计时timer（会记录timer开始时间）
 *  @param timerKey key
 *  @param view 展示倒计时的Label 或 button
 *  @return timer实例
 */
+ (dispatch_source_t)SSstartTiming:(NSString *)timerKey seconds:(int)seconds tipView:(UIView *)view endTitle:(NSString*)title;

/**
 *  timer自动倒计时（如果没有开始时间，直接return）
 *  @param timerKey key
 *  @param view 展示倒计时的Label 或 button
 *  @param forceStart 是否强制启动timer（如果是NO，则时间超过后不会启动新timer）
 *  @return timer实例
 */
//+ (dispatch_source_t)SSTiming:(NSString *)timerKey seconds:(int)seconds tipView:(UIView *)view endTitle:(NSString*)title forceStart:(BOOL)forceStart;

/**
 *  取消timer
 *  @param timerKey key
 *  @param title 结束后的显示标题
 */
+ (void)SScancelTiming:(NSString*)timerKey andTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
