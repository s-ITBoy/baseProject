//
//  SStimingHelperForBtn.h
//  ddz
//
//  Created by F S on 2017/1/7.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SStimingHelperForBtn : NSObject
/**
 *  开启倒计时timer（会记录timer开始时间）
 *  @param timerKey key
 *  @param button 展示倒计时的Label
 *  @return timer实例
 */
+ (dispatch_source_t)startTimerWithKey:(NSString *)timerKey seconds:(int)seconds tipButton:(UIButton *)button endTitle:(NSString*)title;

/**
 *  timer自动倒计时（如果没有开始时间，直接return）
 *  @param timerKey key
 *  @param button 展示倒计时的Label
 *  @param forceStart 是否强制启动timer（如果是NO，则时间超过后不会启动新timer）
 *  @return timer实例
 */
+ (dispatch_source_t)timerCountDownWithKey:(NSString *)timerKey seconds:(int)seconds tipButton:(UIButton *)button endTitle:(NSString*)title forceStart:(BOOL)forceStart;

/**
 *  取消timer
 *  @param timerKey key
 *  @param title 结束后的显示标题
 */
+ (void)cancelTimerByKey:(NSString *)timerKey andTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
