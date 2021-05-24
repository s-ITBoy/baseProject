//
//  UIColor+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIColor+SS.h"

@implementation UIColor (SS)
///标题颜色
+ (UIColor*)SStitleColor51{
    return [UIColor SScolorWithR:51 G:51 B:51];
}
///子标题颜色
+ (UIColor*)SSsubTitleColor136{
    return [UIColor SScolorWithR:153 G:153 B:153];
}

+ (UIColor*)SScolor71{
    return [UIColor SScolorWithR:71 G:71 B:71];
}
+ (UIColor*)SScolor110{
    return [UIColor SScolorWithR:110 G:110 B:110];
}

///主要的红色
+ (UIColor*)SSredColor{
    return [UIColor SScolorWithR:255 G:190 B:0];
}

///自定义蓝色
+ (UIColor*)SSBlueColor{
    return [UIColor SScolorWithR:0 G:112 B:201];
}

+ (UIColor*)SScolorInteger:(NSInteger)integer {
    return [UIColor SScolorWithR:integer G:integer B:integer];
}

+(UIColor*)SScolorWithR:(NSInteger)interR G:(NSInteger)interG B:(NSInteger)interB{
    return [UIColor colorWithRed:interR/255.0 green:interG/255.0 blue:interB/255.0 alpha:1];
}

///十六进制颜色
+ (UIColor *) SScolorWithHexString: (NSString *)colorString {
    return [UIColor SScolorWithHexString:colorString andAlpha:1];
}

///十六进制颜色带透明度值
+ (UIColor *) SScolorWithHexString: (NSString *)colorString andAlpha:(CGFloat)alpha {
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

///黑色
+ (UIColor *) SScolorWithHex000000 {
    return [UIColor SScolorWithHexString:@"#000000" andAlpha:1];
}

///深灰
+ (UIColor *) SScolorWithHex010101 {
    return [UIColor SScolorWithHexString:@"#010101" andAlpha:1];
}

///浅灰
+ (UIColor *) SScolorWithHex999999 {
    return [UIColor SScolorWithHexString:@"#999999" andAlpha:1];
}

+ (UIColor *) SScolorWithHex666666 {
    return [UIColor SScolorWithHexString:@"#666666" andAlpha:1];
}

+ (UIColor *) SScolorWithHex333333 {
    return [UIColor SScolorWithHexString:@"#333333" andAlpha:1];
}

+ (UIColor *) SScolorWithHexCCCCCC {
    return [UIColor SScolorWithHexString:@"#CCCCCC" andAlpha:1];
}

///完成/确定按钮背景色
+ (UIColor *) SSbtncolorHex {
    return [UIColor SScolorWithHexString:@"#C2AB82" andAlpha:1];
}

///shadow边缘阴影颜色
+ (UIColor*) SSshadowColor {
    return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
}

///table的分区背景色
+ (UIColor*)SSsectionColor{
    return [UIColor SScolorWithR:244 G:244 B:244];
}

///borderColor(浅灰)
+ (UIColor*)SSborderColor{
    return [UIColor SScolorWithR:178 G:178 B:178];
}

///分割线颜色
+ (UIColor*)SSseparatorColor{
    return [UIColor SScolorWithR:237 G:237 B:237];
}

///金额数的字体颜色
+ (UIColor*)SSmoneyColor{
    return [UIColor SScolorWithHexString:@"#856020"];;
}

///销售价格的颜色
+ (UIColor*)SSpriceColor {
    return [UIColor SScolorWithHexString:@"#856050"];;
}


///ios13以后的适配系统深色模式的动态颜色方法
+ (UIColor*)SSdynamic:(UIColor*)lightColor dark:(UIColor*_Nullable)darkColor {
    if (@available(iOS 13.0, *)) {
        UIColor* color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return lightColor;
            } else {
                return darkColor ? darkColor : lightColor;
            }
        }];
        return color;
    } else {
        return lightColor;
    }
}

@end
