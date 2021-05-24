//
//  UIColor+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SS)
+ (UIColor*)SScolorWithR:(NSInteger)interR G:(NSInteger)interG B:(NSInteger)interB;
+ (UIColor*)SScolorInteger:(NSInteger)integer;
///标题颜色
+ (UIColor*)SStitleColor51;
///子标题颜色
+ (UIColor*)SSsubTitleColor136;

+ (UIColor*)SScolor71;

+ (UIColor*)SScolor110;

///自定义蓝色
+ (UIColor*)SSBlueColor;



///主要的红色
+ (UIColor*)SSredColor;


///十六进制颜色
+ (UIColor *) SScolorWithHexString: (NSString *)colorString;
///十六进制颜色带透明度值
+ (UIColor *) SScolorWithHexString: (NSString *)colorString andAlpha:(CGFloat)alpha;
///黑色
+ (UIColor *) SScolorWithHex000000;
///深灰
+ (UIColor *) SScolorWithHex010101;
///浅灰
+ (UIColor *) SScolorWithHex999999;
///666666
+ (UIColor *) SScolorWithHex666666;
///333333
+ (UIColor *) SScolorWithHex333333;

+ (UIColor *) SScolorWithHexCCCCCC;

///完成/确定按钮背景色
+ (UIColor *) SSbtncolorHex;
///shadow边缘阴影颜色
+ (UIColor*) SSshadowColor;
///borderColor(浅灰)
+ (UIColor*)SSborderColor;
///分割线颜色
+ (UIColor*)SSseparatorColor;
///table的分区背景色
+ (UIColor*)SSsectionColor;
///金额数的字体颜色
+ (UIColor*)SSmoneyColor;
///销售价格的颜色
+ (UIColor*)SSpriceColor;

///ios13以后的适配系统深色模式的动态颜色方法
+ (UIColor*)SSdynamic:(UIColor*)lightColor dark:(UIColor*_Nullable)darkColor;

@end
