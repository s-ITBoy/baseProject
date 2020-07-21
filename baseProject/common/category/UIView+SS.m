//
//  UIView+SS.m
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "UIView+SS.h"
#import <objc/runtime.h>
#import "UIColor+SS.h"

#define BTN_MODAL_KEY           @"identifier"

//static char topNameKey;
//static char rightNameKey;
//static char bottomNameKey;
//static char leftNameKey;

@implementation UIView (SS)

#pragma mark ----------- frame -----------------------
- (void)setXX:(CGFloat)XX {
    CGRect rect = self.frame;
    rect.origin.x = XX;
    self.frame = rect;
}
- (CGFloat)XX {
    return self.frame.origin.x;
}
- (void)setYY:(CGFloat)YY {
    CGRect rect = self.frame;
    rect.origin.y = YY;
    self.frame = rect;
}
- (CGFloat)YY {
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setSize:(CGSize)Size {
    CGRect newframe = self.frame;
    newframe.size = Size;
    self.frame = newframe;
}
- (CGSize)Size {
    return self.frame.size;
}
- (void)setOringin:(CGPoint)Oringin {
    CGRect newframe = self.frame;
    newframe.origin = Oringin;
    self.frame = newframe;
}
- (CGPoint)Oringin {
    return self.frame.origin;
}

//设置唯一标识 类似tag  jjl
- (void)setIdentifier:(NSString *)identifier{
    objc_setAssociatedObject(self, BTN_MODAL_KEY, identifier, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)identifier{
    NSString *modal = objc_getAssociatedObject(self, BTN_MODAL_KEY);
    return modal;
}

#pragma mark ----------- style -----------------------
/**
 通过贝塞尔曲线添加圆角
 @param cornerRadius 圆角大小
 */
- (void)SSaddCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/**
 通过贝塞尔曲线添加个别圆角
 @param cornerRadius 圆角大小
 @param corners 需要添加的角
 */
- (void)SSaddCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark ------------ 设置上，下，左，右 的边缘线条 ---------------
///设置顶部边缘线条。bottom：表示线条的高度
- (void)SSaddTopInsetLine:(UIEdgeInsets)topInset andlineColor:(UIColor*)color {
    UILabel* line = (UILabel*)[self viewWithTag:10010];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = color ? color : [UIColor SSseparatorColor];
        line.frame = CGRectMake(topInset.left, topInset.top, self.frame.size.width- topInset.left- topInset.right, topInset.bottom);
        [self addSubview:line];
    }
    
    line.hidden = topInset.bottom == 0;
}
///设置左侧边缘线条。right：表示线条的宽度
- (void)SSaddLeftInsetLine:(UIEdgeInsets)leftInset andlineColor:(UIColor*)color {
    UILabel* line = (UILabel*)[self viewWithTag:10020];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = color ? color : [UIColor SSseparatorColor];
        line.frame = CGRectMake(leftInset.left, leftInset.top, leftInset.right, self.frame.size.height- leftInset.top - leftInset.bottom);
        [self addSubview:line];
    }
    
    line.hidden = leftInset.right == 0;
}
///设置底部边缘线条。top：表示线条的高度
- (void)SSaddBottomInsetLine:(UIEdgeInsets)bottomInset andlineColor:(UIColor*)color {
    UILabel* line = (UILabel*)[self viewWithTag:10030];
    if (!line) {
        line = [UILabel new];
        line.backgroundColor = color ? color : [UIColor SSseparatorColor];
        line.frame = CGRectMake(bottomInset.left, self.frame.size.height- bottomInset.top- bottomInset.bottom, self.frame.size.width- bottomInset.left- bottomInset.right, bottomInset.top);
        [self addSubview:line];
    }
    
    line.hidden = bottomInset.top == 0;
}
///设置右侧边缘线条。left：表示线条的宽度
- (void)SSaddRightInsetLine:(UIEdgeInsets)rightInset andlineColor:(UIColor*)color {
    UILabel* line = (UILabel*)[self viewWithTag:10040];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = color ? color : [UIColor SSseparatorColor];
        line.frame = CGRectMake(self.frame.size.width- rightInset.left- rightInset.right, rightInset.top, rightInset.left, self.frame.size.height- rightInset.top- rightInset.bottom);
        [self addSubview:line];
        [self bringSubviewToFront:line];
    }
    
    line.hidden = rightInset.left == 0;
}

#pragma mark -------------  设置视图的layer层的圆角，线宽及颜色等 -----------
///设置圆角半径lineWidth==0时，表示不设置线宽
- (void)SSsetlayerOfViewRadius:(CGFloat)cornerRadius andLineWidth:(CGFloat)lineWidth andLineCorlor:(UIColor*)lineColor {
    self.layer.cornerRadius = cornerRadius;
    if (lineWidth != 0) {
        self.layer.borderWidth = lineWidth;
    }
    if (lineColor) {
        self.layer.borderColor = lineColor.CGColor;
    }
    self.layer.masksToBounds = YES;
}
///设置边缘阴影
- (void)SSsetLayshadowwithRadiu:(CGFloat)radiu andShadowOffset:(CGSize)size andShadowCorlor:(UIColor*)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = radiu;
}

///颜色渐变
- (void)SSsetColor:(UIColor*)color1 and:(UIColor*)color2 and:(CGPoint)start and:(CGPoint)end {
    CAGradientLayer *gl = [[CAGradientLayer alloc] init];
    gl.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.layer addSublayer:gl];
}


- (void)SSremoveAllSubViews {
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark ------------ 动画效果 ------------
///缩放动画
- (void)SSaddZoomAnimationFrom:(CGFloat)min To:(CGFloat)max {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.5;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;///是否运行逆向变化动画
    animation.timeOffset = 1;
    animation.fromValue = [NSNumber numberWithFloat:min];
    animation.toValue = [NSNumber numberWithFloat:max];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"scale-layer"];
}

///适用于点击选中放大/缩小的动画
- (void)SStransformAnimate:(CGFloat)scaleX and:(CGFloat)scaleY Interval:(CGFloat)interval {
    [UIView animateWithDuration:interval animations:^{
        self.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    }];
}

///移除动画
- (void)SSremoveAllAnimation {
    [self.layer removeAllAnimations];
}

@end
