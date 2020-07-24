//
//  SSwaterWaveView.h
//  baseProject
//
//  Created by F S on 2020/7/24.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///渐变色波纹动画视图控件(三角函数状波纹)
@interface SSwaterWaveView : UIView
/** 振幅*/
@property (nonatomic, assign) CGFloat waveAmplitude;
/** 周期*/
@property (nonatomic, assign) CGFloat waveCycle;
/** 速度*/
@property (nonatomic, assign) CGFloat waveSpeed;

@property (nonatomic, assign) CGFloat wavePointY;
/** 波浪x位移*/
@property (nonatomic, assign) CGFloat waveOffsetX;


///一条波纹
- (instancetype)initOneWaveWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
///两条波纹
- (instancetype)initTwoWaveWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
