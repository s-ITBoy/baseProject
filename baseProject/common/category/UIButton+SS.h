//
//  UIButton+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (SS)

///创建按钮（简单属性）
+(UIButton*_Nonnull)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*_Nullable)font;
///创建按钮（简单属性带有背景色）
+(UIButton*_Nonnull)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*_Nullable)font bgColor:(UIColor* _Nullable)bgColor;
///创建按钮（简单属性带有背景图）
+(UIButton*_Nonnull)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*_Nullable)font bgImgStr:(NSString* _Nullable)imgStr;
///创建按钮（带有全面属性）
+ (UIButton*_Nonnull)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor selectedTitle:(NSString* _Nullable)selectTitle selectedColor:(UIColor* _Nullable)selectColor font:(UIFont*_Nullable)font bgColor:(UIColor* _Nullable)bgColor bgImg:(NSString* _Nullable)bgimgStr;

#pragma mark ------- 创建特定的按钮 ----------
///确认按钮
+ (UIButton*_Nonnull)SSokBtn;
///登录/退出按钮
+ (UIButton*_Nonnull)SSloginQuitBtn;

@end

