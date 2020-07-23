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
-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterx:(CGFloat)centerx{
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}
- (CGFloat)centerx{
    return self.center.x;
}

- (void)setCentery:(CGFloat)centery{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}
- (CGFloat)centery{
    return self.center.y;
}



- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
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
    UIView* line = [self viewWithTag:10010];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = 10010;
        [self addSubview:line];
    }
    line.backgroundColor = color ? color : [UIColor SScolorWithHexString:@"#6D6D6F"];
    line.frame = CGRectMake(topInset.left, topInset.top, self.frame.size.width- topInset.left- topInset.right, topInset.bottom);
    line.hidden = topInset.bottom == 0;
}
///设置左侧边缘线条。right：表示线条的宽度
- (void)SSaddLeftInsetLine:(UIEdgeInsets)leftInset andlineColor:(UIColor*)color {
    UIView* line = [self viewWithTag:10020];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = 10020;
        [self addSubview:line];
    }
    line.frame = CGRectMake(leftInset.left, leftInset.top, leftInset.right, self.frame.size.height- leftInset.top - leftInset.bottom);
    line.backgroundColor = color ? color : [UIColor SScolorWithHexString:@"#6D6D6F"];
    [self bringSubviewToFront:line];
    line.hidden = leftInset.right == 0;
}
///设置底部边缘线条。top：表示线条的高度
- (void)SSaddBottomInsetLine:(UIEdgeInsets)bottomInset andlineColor:(UIColor*)color {
    UIView* line = [self viewWithTag:10030];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = 10030;
        [self addSubview:line];
    }
    line.backgroundColor = color ? color : [UIColor SScolorWithHexString:@"#6D6D6F"];
    line.frame = CGRectMake(bottomInset.left, self.frame.size.height- bottomInset.top- bottomInset.bottom, self.frame.size.width- bottomInset.left- bottomInset.right, bottomInset.top);
    
    line.hidden = bottomInset.top == 0;
}
///设置右侧边缘线条。left：表示线条的宽度
- (void)SSaddRightInsetLine:(UIEdgeInsets)rightInset andlineColor:(UIColor*)color {
    UIView* line = [self viewWithTag:10040];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = 10040;
        [self addSubview:line];
        [self bringSubviewToFront:line];
    }
    line.backgroundColor = color ? color : [UIColor SScolorWithHexString:@"#6D6D6F"];
    line.frame = CGRectMake(self.frame.size.width- rightInset.left- rightInset.right, rightInset.top, rightInset.left, self.frame.size.height- rightInset.top- rightInset.bottom);
    
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
//    self.layer.masksToBounds = YES;
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
/*
 在 iOS 动画开发中经常使用到的 animationWithKeyPath:字符串,以下为部分内容:
 // 旋转
 transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
 transform.rotation.y 围绕y轴翻转 参数：同上
 transform.rotation.z 围绕z轴翻转 参数：同上
 transform.rotation 默认围绕z轴
 // 缩放
 transform.scale.x x方向缩放 参数：缩放比例 1.5
 transform.scale.y y方向缩放 参数：同上
 transform.scale.z z方向缩放 参数：同上
 transform.scale 所有方向缩放 参数：同上
 // 平移
 transform.translation.x x方向移动 参数：x轴上的坐标 100
 transform.translation.y x方向移动 参数：y轴上的坐标
 transform.translation.z x方向移动 参数：z轴上的坐标
 transform.translation 移动 参数：移动到的点 （100，100）
 // 其他属性
 opacity 透明度 参数：透明度 0.5
 backgroundColor 背景颜色 参数：颜色 (id)[[UIColor redColor] CGColor]
 cornerRadius 圆角 参数：圆角半径 5
 borderWidth 边框宽度 参数：边框宽度 5
 bounds 大小 参数：CGRect
 contents 内容 参数：CGImage
 contentsRect 可视内容 参数：CGRect 值是0～1之间的小数
 position 锚点位置
 shadowColor 阴影颜色
 shadowOffset 阴影的偏移量
 shadowOpacity 阴影的透明度
 shadowRadius 阴影的圆角
 */
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

///呼吸动画
- (void)SSbreatheAnimate {
    CABasicAnimation* baseAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    baseAni.fromValue = [NSNumber numberWithFloat:1.0f];
    baseAni.toValue = [NSNumber numberWithFloat:0.2f];
    baseAni.autoreverses = YES;
    baseAni.duration = 1;
    baseAni.repeatCount = MAXFLOAT;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode =  kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:baseAni forKey:@"breathe"];
}

///边框线向外扩散动画
- (void)SSborderlineAnimate:(CGFloat)min and:(CGFloat)max {
    CABasicAnimation* baseAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAni.fromValue = @(min);
    baseAni.toValue = @(max);
    baseAni.duration = 2;
    baseAni.repeatCount = HUGE;
    
    CALayer* layer = [CALayer layer];
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 0.5;
    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    layer.cornerRadius = self.bounds.size.height/2;
    [layer addAnimation:baseAni forKey:@"borderline"];
    [self.layer addSublayer:layer];
}

///边框线向外扩散动画(去锯齿)
- (void)SSborderAnimate:(CGFloat)min and:(CGFloat)max {
    CABasicAnimation* baseAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAni.fromValue = @(min);
    baseAni.toValue = @(max);
    
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)[UIColor blackColor].CGColor,
                                    (__bridge id)[UIColor blackColor].CGColor,
                                    (__bridge id)[UIColor blackColor].CGColor,
                                    (__bridge id)[UIColor blackColor].CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 2;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = @[baseAni,borderColorAnimation];
    animationGroup.removedOnCompletion = NO;
    
    self.layer.borderWidth = 0.5;
    [self.layer addAnimation:animationGroup forKey:@"border"];
}

///背景颜色向外扩散动画
- (void)SSbackgroundColorAnimate:(CGFloat)min and:(CGFloat)max {
    CABasicAnimation* baseAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAni.fromValue = @(min);
    baseAni.toValue = @(max);
    
    CAKeyframeAnimation *backgroundColorAnimation = [CAKeyframeAnimation animation];
    backgroundColorAnimation.keyPath = @"backgroundColor";
    backgroundColorAnimation.values = @[(__bridge id)RGBA(255, 216, 87, 0.5).CGColor,
                                        (__bridge id)RGBA(255, 231, 152, 0.5).CGColor,
                                        (__bridge id)RGBA(255, 241, 197, 0.5).CGColor,
                                        (__bridge id)RGBA(255, 241, 197, 0).CGColor];
    backgroundColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 2;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = @[baseAni,backgroundColorAnimation];
    animationGroup.removedOnCompletion = NO;
    
    [self.layer addAnimation:animationGroup forKey:@"backgroundColor"];
}

// CATransition转场动画
/*
 type    动画过渡类型
 subtype    动画过渡方向
 
 常用动画类型:
 type的值                  解读        对应常量
 fade                     淡入淡出     kCATransitionFade
 push                     推挤        kCATransitionPush
 reveal                   揭开        kCATransitionReveal
 moveIn                   覆盖        kCATransitionMoveIn
 cube                     立方体      私有API
 suckEffect               吮吸        私有API
 oglFlip                  翻转        私有API
 rippleEffect             波纹        私有API
 pageCurl                 反翻页      私有API
 cameraIrisHollowOpen     开镜头      私有API
 cameraIrisHollowClose    关镜头      私有API

 过渡方向参数:
 subtype的值    解读
 kCATransitionFromRight    从右转场
 kCATransitionFromLeft     从左转场
 kCATransitionFromBottom   从下转场
 kCATransitionFromTop      从上转场

 */

///翻页动画
- (void)SSopenPageAnimate {
    [self.layer removeAllAnimations];
    CATransition* transition = [CATransition animation];
    transition.repeatCount = 5;
    transition.type = @"pageCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1;
    [self.layer addAnimation:transition forKey:nil];
}
///立方体转动动画
- (void)SScubeAnimate {
    [self.layer removeAllAnimations];
    CATransition* transition = [CATransition animation];
    transition.repeatCount = 5;
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1;
    
    [self.layer addAnimation:transition forKey:nil];
}

///移除动画
- (void)SSremoveAllAnimation {
    [self.layer removeAllAnimations];
}

@end
