//
//  UIButton+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIButton+SS.h"
#import <objc/runtime.h>

@implementation UIButton (SS)

///创建按钮（简单属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

///创建按钮（简单属性带有背景色）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    return button;
}

///创建按钮（简单属性带有背景图）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgImgStr:(NSString* _Nullable)imgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (imgStr) {
        [button setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    }
    return button;
}

///创建按钮（带有全面属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor selectedTitle:(NSString* _Nullable)selectTitle selectedColor:(UIColor* _Nullable)selectColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor bgImg:(NSString* _Nullable)bgimgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectColor) {
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = font;
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    if (bgimgStr) {
        [button setBackgroundImage:[UIImage imageNamed:bgimgStr] forState:UIControlStateNormal];
    }
    
    return button;
}


#pragma ---------------扩大响应区域----------------
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

-(void)SSaddEnlargeEdge:(CGFloat) size{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)SSaddEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(UIView*)hitTest:(CGPoint) point withEvent:(UIEvent*) event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

-(CGRect)enlargedRect{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}
@end
