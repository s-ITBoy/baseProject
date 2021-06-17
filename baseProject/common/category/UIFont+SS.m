//
//  UIFont+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIFont+SS.h"

@implementation UIFont (SS)

#pragma mark ---------- 系统 ---------
+(UIFont*)SSfontWith:(CGFloat)size{
    return [UIFont SSsystemFont:size];
}
+(UIFont*)SSfont23{
    return [UIFont SSsystemFont:23];
}
+(UIFont*)SSfont20{
    return [UIFont SSsystemFont:20];
}
+(UIFont*)SSfont18 {
    return [UIFont SSsystemFont:18];
}
+(UIFont*)SSfont17{
    return [UIFont SSsystemFont:17];
}
+(UIFont*)SSfont16{
    return [UIFont SSsystemFont:16];
}
+(UIFont*)SSfont15{
    return [UIFont SSsystemFont:15];
}
+(UIFont*)SSfont14{
    return [UIFont SSsystemFont:14];
}
+(UIFont*)SSfont13{
    return [UIFont SSsystemFont:13];
}
+(UIFont*)SSfont12{
    return [UIFont SSsystemFont:12];
}
+(UIFont*)SSfont11{
    return [UIFont SSsystemFont:11];
}
+(UIFont*)SSfont10{
    return [UIFont SSsystemFont:10];
}
+(UIFont*)SSsystemFont:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize*Scale];
}

#pragma mark ---------- 系统 ---------
+ (UIFont*)SSboldFont12 {
    return [UIFont SSboldFont:12];
}
+ (UIFont*)SSboldFont13  {
    return [UIFont SSboldFont:13];
}
+ (UIFont*)SSboldFont14  {
    return [UIFont SSboldFont:14];
}
+ (UIFont*)SSboldFont15 {
    return [UIFont SSboldFont:15];
}
+ (UIFont*)SSboldFont16  {
    return [UIFont SSboldFont:16];
}
+ (UIFont*)SSboldFont17  {
    return [UIFont SSboldFont:17];
}
+ (UIFont*)SSboldFont18  {
    return [UIFont SSboldFont:18];
}
+ (UIFont*)SSboldFont20  {
    return [UIFont SSboldFont:20];
}
+ (UIFont*)SSboldFont24  {
    return [UIFont SSboldFont:24];
}
+ (UIFont*)SSboldFont:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size*Scale];
}

#pragma mark ---------- 自定义 ---------
+ (UIFont*)SSCustomFont10 {
    return [UIFont SSCustomFont:10];
}
+ (UIFont*)SSCustomFont11 {
    return [UIFont SSCustomFont:11];
}
+ (UIFont*)SSCustomFont12{
    return [UIFont SSCustomFont:12];
}
+ (UIFont*)SSCustomFont13 {
    return [UIFont SSCustomFont:13];
}
+ (UIFont*)SSCustomFont14 {
    return [UIFont SSCustomFont:14];
}
+ (UIFont*)SSCustomFont15 {
    return [UIFont SSCustomFont:15];
}
+ (UIFont*)SSCustomFont16 {
    return [UIFont SSCustomFont:16];
}
+ (UIFont*)SSCustomFont17 {
    return [UIFont SSCustomFont:17];
}
+ (UIFont*)SSCustomFont18 {
    return [UIFont SSCustomFont:18];
}
+ (UIFont*)SSCustomFont20 {
    return [UIFont SSCustomFont:20];
}
+ (UIFont*)SSCustomFont24 {
    return [UIFont SSCustomFont:24];
}
+ (UIFont*)SSCustomFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:size*Scale];
}

#pragma mark ---------- 自定义 加粗 ---------
+ (UIFont*)SScustomboldFont12 {
    return [UIFont SSCustomBoldFont:12];
}
+ (UIFont*)SScustomboldFont13 {
    return [UIFont SSCustomBoldFont:13];
}
+ (UIFont*)SScustomboldFont14 {
    return [UIFont SSCustomBoldFont:14];
}
+ (UIFont*)SScustomboldFont15 {
    return [UIFont SSCustomBoldFont:15];
}
+ (UIFont*)SScustomboldFont16 {
    return [UIFont SSCustomBoldFont:16];
}
+ (UIFont*)SScustomboldFont17 {
    return [UIFont SSCustomBoldFont:17];
}
+ (UIFont*)SScustomboldFont18 {
    return [UIFont SSCustomBoldFont:18];
}
+ (UIFont*)SScustomboldFont20 {
    return [UIFont SSCustomBoldFont:20];
}
+ (UIFont*)SScustomboldFont24 {
    return [UIFont SSCustomBoldFont:24];
}
+ (UIFont*)SSCustomBoldFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Medium" size:size*Scale];
}

@end
