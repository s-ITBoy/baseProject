//
//  UIButton+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIButton+SS.h"
#import <objc/runtime.h>

@implementation UIButton (SS)

///创建按钮（简单属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

///创建按钮（简单属性带有背景色）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    return button;
}

///创建按钮（简单属性带有背景图）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgImgStr:(NSString* _Nullable)imgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (imgStr) {
        [button setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    }
    return button;
}

///创建按钮（带有全面属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor selectedTitle:(NSString* _Nullable)selectTitle selectedColor:(UIColor* _Nullable)selectColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor bgImg:(NSString* _Nullable)bgimgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectColor) {
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = font;
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    if (bgimgStr) {
        [button setBackgroundImage:[UIImage imageNamed:bgimgStr] forState:UIControlStateNormal];
    }
    
    return button;
}

#pragma mark ------- 创建特定的按钮 ----------
///确认按钮
+ (UIButton*_Nonnull)SSokBtn {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont SSCustomFont16];
    [button setBackgroundColor:[UIColor SScolorWithHexString:@"#0A6DF7"]];
//    [button setTitle:@"" forState:UIControlStateNormal];
    
    return button;
}
///登录/退出按钮
+ (UIButton*_Nonnull)SSloginQuitBtn {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont SSfont14];
    [button setBackgroundColor:[UIColor SScolorWithHexString:@"#0A6DF7"]];
//    [button setTitle:@"" forState:UIControlStateNormal];
    
    return button;
}

@end
