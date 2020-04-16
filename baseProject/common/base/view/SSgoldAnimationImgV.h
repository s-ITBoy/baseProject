//
//  SSgoldAnimationImgV.h
//  baseProject
//
//  Created by F S on 2020/4/16.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, ShootAnimationType) {
    ShootAnimationTypeLine       = 0,  //直线
    ShootAnimationTypeCurve      = 1,  //曲线
};

//默认设置
@interface ShootSetting : NSObject
///动画产生imagView的个数，默认10个
@property (nonatomic, assign) int totalCount;
///产生imageView的时间间隔，默认0.1
@property (nonatomic, assign) CGFloat timeSpace;
///动画时长， 默认1s
@property (nonatomic, assign) CGFloat duration;
///图片，默认为button自身图片
@property (nonatomic, strong) UIImage *iconImage;
///动画类型，默认曲线
@property (nonatomic, assign) ShootAnimationType animationType;
// Factory method to help build a default setting
+ (ShootSetting *)defaultSetting;
@end

@interface SSgoldAnimationImgV : UIImageView
@property (nonatomic, strong) ShootSetting *setting;

- (instancetype)initWithFrame:(CGRect)frame andEndPoint:(CGPoint)point;

///添加金币进袋的图片动画效果imgView
- (void)startAnimation;
@end

NS_ASSUME_NONNULL_END
