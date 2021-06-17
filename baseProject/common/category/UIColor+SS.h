//
//  UIColor+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SS)
+ (UIColor*_Nullable)SScolorWithR:(NSInteger)interR G:(NSInteger)interG B:(NSInteger)interB;
+ (UIColor*_Nullable)SScolorInteger:(NSInteger)integer;
///标题颜色
+ (UIColor*_Nullable)SStitleColor51;
///子标题颜色
+ (UIColor*_Nullable)SSsubTitleColor136;

+ (UIColor*_Nullable)SScolor71;

+ (UIColor*_Nullable)SScolor110;

///自定义蓝色
+ (UIColor*_Nullable)SSBlueColor;



///主要的红色
+ (UIColor*_Nullable)SSredColor;


///十六进制颜色
+ (UIColor*_Nullable) SScolorWithHexString: (NSString *_Nullable)colorString;
///十六进制颜色带透明度值
+ (UIColor*_Nullable) SScolorWithHexString: (NSString *_Nullable)colorString andAlpha:(CGFloat)alpha;
///黑色
+ (UIColor*_Nullable) SScolorWithHex000000;
///深灰
+ (UIColor*_Nullable) SScolorWithHex010101;
///浅灰
+ (UIColor*_Nullable) SScolorWithHex999999;
///666666
+ (UIColor*_Nullable) SScolorWithHex666666;
///333333
+ (UIColor*_Nullable) SScolorWithHex333333;

+ (UIColor*_Nullable) SScolorWithHexCCCCCC;

///完成/确定按钮背景色
+ (UIColor*_Nullable) SSbtncolorHex;
///shadow边缘阴影颜色
+ (UIColor*_Nullable) SSshadowColor;
///borderColor(浅灰)
+ (UIColor*_Nullable)SSborderColor;
///分割线颜色
+ (UIColor*_Nullable)SSseparatorColor;
///table的分区背景色
+ (UIColor*_Nullable)SSsectionColor;
///金额数的字体颜色
+ (UIColor*_Nullable)SSmoneyColor;
///销售价格的颜色
+ (UIColor*_Nullable)SSpriceColor;

///ios13以后的适配系统深色模式的动态颜色方法
+ (UIColor*_Nullable)SSdynamic:(UIColor*_Nullable)lightColor dark:(UIColor*_Nullable)darkColor;

@end
