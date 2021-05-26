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

@end

NS_ASSUME_NONNULL_END
