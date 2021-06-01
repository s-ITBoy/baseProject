//
//  UILabel+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SS)

///创建Label(默认左对齐)
+(UILabel*_Nonnull)SSlabel:(UIFont*_Nullable)font textColor:(UIColor*_Nullable)textColor backgroundColor:(UIColor*_Nullable)bgcolor;

///创建Label
+(UILabel*_Nonnull)SSlabel:(UIFont*_Nullable)font textAlignment:(NSTextAlignment)alignment textColor:(UIColor*_Nullable)textColor backgroundColor:(UIColor*_Nullable)bgcolor;


#pragma mark --------- 创建特定的Lab -----------
///字号16单行无背景色的Lab
+ (UILabel*)SSfont16OneLineLab;
///字号16多行无背景色的Lab
+ (UILabel*)SSfont16LinesLab;

@end

NS_ASSUME_NONNULL_END
