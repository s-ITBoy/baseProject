//
//  UIView+SS.h
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SS)

#pragma mark ----------- frame -----------------------
///直接获得,或者设置, View 的 x 坐标
@property(nonatomic,assign) CGFloat x;
///直接获得,或者设置, View 的 y 坐标
@property(nonatomic,assign) CGFloat y;
///直接获得一个View的宽度
@property(nonatomic,assign) CGFloat width;
///直接获得一个 View 的高度
@property(nonatomic,assign) CGFloat height;
///
@property(nonatomic,assign) CGFloat centerx;
///
@property(nonatomic,assign) CGFloat centery;

@property(nonatomic,assign) CGFloat top;
@property(nonatomic,assign) CGFloat left;

@property(nonatomic,assign) CGFloat bottom;
@property(nonatomic,assign) CGFloat right;


@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign) CGSize size;

@property (nonatomic, readwrite,strong) NSString *identifier;

#pragma mark ----------- style -----------------------
/**
 通过贝塞尔曲线添加圆角
 @param cornerRadius 圆角大小
 */
- (void)SSaddCornerRadius:(CGFloat)cornerRadius;
/**
 通过贝塞尔曲线添加个别圆角
 @param cornerRadius 圆角大小
 @param corners 需要添加的角
 */
- (void)SSaddCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;

#pragma mark ------------ 设置上，下，左，右 的边缘线条 ---------------
///设置顶部边缘线条。bottom：表示线条的高度
- (void)SSaddTopInsetLine:(UIEdgeInsets)topInset andlineColor:(UIColor*)color;
///设置左侧边缘线条。right：表示线条的宽度
- (void)SSaddLeftInsetLine:(UIEdgeInsets)leftInset andlineColor:(UIColor*)color;
///设置底部边缘线条。top：表示线条的高度
- (void)SSaddBottomInsetLine:(UIEdgeInsets)bottomInset andlineColor:(UIColor*)color;
///设置右侧边缘线条。left：表示线条的宽度
- (void)SSaddRightInsetLine:(UIEdgeInsets)rightInset andlineColor:(UIColor*)color;

#pragma mark -------------  设置视图的layer层的圆角，线宽及颜色等 -----------
///设置圆角半径lineWidth==0时，表示不设置线宽
- (void)SSsetlayerOfViewRadius:(CGFloat)cornerRadius andLineWidth:(CGFloat)lineWidth andLineCorlor:(UIColor*)lineColor;
///设置边缘阴影
- (void)SSsetLayshadowwithRadiu:(CGFloat)radiu andShadowOffset:(CGSize)size andShadowCorlor:(UIColor*)shadowColor;

#pragma mark ------------ 动画效果 ------------
///缩放动画
- (void)SSaddZoomAnimationFrom:(CGFloat)min To:(CGFloat)max;

///移除动画
- (void)SSremoveAllAnimation;


///移除所有子视图
- (void)SSremoveAllSubViews;

@end

