//
//  UIImage+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SS)
///给图片添加透明度
+ (UIImage *)SSimageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *  @return UIImage
 */
+ (UIImage *)SSimageFromImage:(UIImage *)image inRect:(CGRect)rect;

/// 压缩图片尺寸 size:压缩的尺寸
- (UIImage *)SSimageScaleWithSize:(CGSize)size;     //此方法压缩图片有问题

- (UIImage*)SSimageByScalingAndCroppingForSize:(CGSize)targetSize;

/// 压缩图片质量
- (UIImage*)SSimageWithScale:(CGFloat)scale;

///根据颜色生成图片
+(UIImage*)SSimageWithColor:(UIColor*)color;

///显示图片本身的样子（而不是根据tintcolor显示图片颜色）
+ (UIImage *)ss_imageRenderOriginalWithName:(NSString *)name;
///图片转成base64格式
- (NSString *)ss_imageToBase64String:(CGFloat)scale;
///图片转成data
- (NSData*)ss_imageToData;

///生成二维码图片
+ (UIImage*)SSgetQRcodeWithStr:(NSString*)str size:(CGFloat)size;
///截取指定视图的指定区域，传入需要截取的view
+ (UIImage*)SSscreenShot:(UIView *)view;

@end

