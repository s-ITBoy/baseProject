//
//  UIFont+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIFont+SS.h"

@implementation UIFont (SS)
+(UIFont*)SSfontWith:(CGFloat)size{
    return [UIFont systemFontOfSize:size*Scale];
}
+(UIFont*)SSfont23{
    return [UIFont systemFontOfSize:23*Scale];
}

+(UIFont*)SSfont20{
    return [UIFont systemFontOfSize:20*Scale];
}

+(UIFont*)SSfont18 {
    return [UIFont systemFontOfSize:18*Scale];
}

+(UIFont*)SSfont17{
    return [UIFont systemFontOfSize:17*Scale];
}

+(UIFont*)SSfont16{
    return [UIFont systemFontOfSize:16*Scale];
}

+(UIFont*)SSfont15{
    return [UIFont systemFontOfSize:15*Scale];
}

+(UIFont*)SSfont14{
    return [UIFont systemFontOfSize:14*Scale];
}

+(UIFont*)SSfont13{
    return [UIFont systemFontOfSize:13*Scale];
}

+(UIFont*)SSfont12{
    return [UIFont systemFontOfSize:12*Scale];
}

+(UIFont*)SSfont11{
    return [UIFont systemFontOfSize:11*Scale];
}

+(UIFont*)SSfont10{
    return [UIFont systemFontOfSize:10*Scale];
}

+ (UIFont*)SSboldFont12 {
    return [UIFont SSboldFont:12*Scale];
}
+ (UIFont*)SSboldFont13  {
    return [UIFont SSboldFont:13*Scale];
}
+ (UIFont*)SSboldFont14  {
    return [UIFont SSboldFont:14*Scale];
}
+ (UIFont*)SSboldFont15 {
    return [UIFont SSboldFont:15*Scale];
}
+ (UIFont*)SSboldFont16  {
    return [UIFont SSboldFont:16*Scale];
}
+ (UIFont*)SSboldFont17  {
    return [UIFont SSboldFont:17*Scale];
}
+ (UIFont*)SSboldFont18  {
    return [UIFont SSboldFont:18*Scale];
}
+ (UIFont*)SSboldFont20  {
    return [UIFont SSboldFont:20*Scale];
}
+ (UIFont*)SSboldFont24  {
    return [UIFont SSboldFont:24*Scale];
}

+ (UIFont*)SSboldFont:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size*Scale];
}

+ (UIFont*)SSCustomFont12{
    return [UIFont SSCustomFont:12*Scale];
}
+ (UIFont*)SSCustomFont13 {
    return [UIFont SSCustomFont:13*Scale];
}
+ (UIFont*)SSCustomFont14 {
    return [UIFont SSCustomFont:14*Scale];
}
+ (UIFont*)SSCustomFont15 {
    return [UIFont SSCustomFont:15*Scale];
}
+ (UIFont*)SSCustomFont16 {
    return [UIFont SSCustomFont:16*Scale];
}
+ (UIFont*)SSCustomFont17 {
    return [UIFont SSCustomFont:17*Scale];
}
+ (UIFont*)SSCustomFont18 {
    return [UIFont SSCustomFont:18*Scale];
}
+ (UIFont*)SSCustomFont20 {
    return [UIFont SSCustomFont:20*Scale];
}
+ (UIFont*)SSCustomFont24 {
    return [UIFont SSCustomFont:24*Scale];
}

+ (UIFont*)SSCustomFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:size*Scale];
}

+ (UIFont*)SSCustomBoldFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Bold" size:size*Scale];
}
@end
