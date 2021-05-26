//
//  SSnaviAndStatusBarV.h
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSnaviType) {
    SSnaviTypeShowDefault,
    SSnaviTypeShowLeftBack,
    SSnaviTypeShowLeftAndRight,
    
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSNaviBtnsBLock)(NSInteger index);

@interface SSnaviAndStatusBarV : UIView
///导航栏标题
@property(nonatomic,strong) NSString* titleStr;

///导航搜索框
@property(nonatomic,strong,readonly) UITextField* searchTFD;
///是否隐藏导航栏中间的搜索框，默认隐藏 YES：隐藏；NO：不隐藏
@property(nonatomic,assign) BOOL isHiddenSearchTFD;
///搜索框占位字符
@property(nonatomic,assign) NSString* searchPlaceHolder;
///搜索框左侧图leftView（图标）
@property(nonatomic,assign) NSString* searchLeftViewImgStr;
///搜索框边框线条颜色
@property(nonatomic,assign) UIColor* searchBorderColor;
///左侧按钮角标
@property(nonatomic,strong) NSString* badgeNum;
///左侧返回按钮图标，默认为黑色的图标
@property(nonatomic,strong) NSString* leftbtnImgStr;
///左侧按钮默认显示
@property(nonatomic,assign) BOOL leftHIdden;
///右侧按钮图标
@property(nonatomic,strong) NSString* rightBtnImgStr;
///是否隐藏右侧按钮 默认隐藏 YES：隐藏；NO：不隐藏
@property(nonatomic,assign) BOOL isHiddenrightBtn;

///0：左侧按钮；1：右侧按钮
@property(nonatomic,copy) SSNaviBtnsBLock naviBlock;
///搜索Block
@property(nonatomic,copy) void (^SSnaviSearchBlock) (NSString* text);
@end

NS_ASSUME_NONNULL_END
