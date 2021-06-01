//
//  UILabel+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UILabel+SS.h"

@implementation UILabel (SS)

///创建Label
+(UILabel*_Nonnull)SSlabel:(UIFont*_Nullable)font textColor:(UIColor*_Nullable)textColor backgroundColor:(UIColor*_Nullable)bgcolor {
    return [UILabel SSlabel:font textAlignment:NSTextAlignmentLeft textColor:textColor backgroundColor:bgcolor];
}

///Label
+ (UILabel*)SSlabel:(UIFont*)font textAlignment:(NSTextAlignment)alignment textColor:(UIColor*)textColor backgroundColor:(UIColor*)bgcolor {
    UILabel* label = [[UILabel alloc] init];
    label.backgroundColor = bgcolor ? bgcolor : [UIColor clearColor];
    label.textAlignment = alignment;
    label.font = font ? font : [UIFont systemFontOfSize:15];
    label.textColor = textColor ? textColor : [UIColor lightGrayColor];
    return label;
}

#pragma mark --------- 创建特定的Lab -----------
///字号16单行无背景色的Lab
+ (UILabel*)SSfont16OneLineLab {
    UILabel* lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:ssscale(16)];
    return lab;
}
///字号16多行无背景色的Lab
+ (UILabel*)SSfont16LinesLab {
    UILabel* lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:ssscale(16)];
    lab.numberOfLines = 0;
    return lab;
}

@end
