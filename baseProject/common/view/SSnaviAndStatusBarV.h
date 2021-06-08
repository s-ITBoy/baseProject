//
//  SSnaviAndStatusBarV.h
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSnaviType) {
    ///默认，显示中间的title、左侧返回图标按钮
    SSnaviTypeShowDefault       = 0,
    ///显示中间的搜索框🔍、左侧返回图标按钮
    SSnaviTypeShowSearch,
    ///左中右纯图标显示，当未设置图标内容时，则为不显示对应图标
    SSnaviTypeShowOnlyPicture,
    ///自定义补充，以便于扩展
    SSnaviTypeShowCustom,
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSNaviBtnsBLock)(NSInteger index);

@interface SSnaviAndStatusBarV : UIView
///默认为SSnaviTypeShowDefault
@property(nonatomic,assign) SSnaviType type;
///导航栏标题
@property(nonatomic,copy) NSString* titleStr;
///导航栏标题颜色 默认黑色
@property(nonatomic,strong) UIColor* titleColor;
///导航栏标题字号大小 默认 15号加粗
@property(nonatomic,strong) UIFont* titleFont;

///当type = SSnaviTypeShowSearch时的，中间的搜索框
@property(nonatomic,strong,readonly) UITextField* searchTFD;
///搜索文字的颜色 默认黑色
@property(nonatomic,strong) UIColor* searchTextColor;
///搜索文字字号大小 默认 14号
@property(nonatomic,strong) UIFont* searchTextFont;
///搜索框占位字符
@property(nonatomic,strong) NSString* searchPlaceHolder;
///搜索框左侧图leftView（图标）
@property(nonatomic,strong) NSString* searchLeftViewImgStr;
///搜索框边框线条颜色
@property(nonatomic,strong) UIColor* searchBorderColor;

///左侧返回按钮图标，默认为黑色的图标
@property(nonatomic,copy) NSString* leftbtnImgStr;
///关闭webView的按钮的图标，适用于webView的VC，此参数仅在默认样式下有用
@property(nonatomic,copy) NSString* closeWebBtnImgStr;
///当为默认样式时，是否显示左侧按钮旁边的关闭按钮 默认NO：不显示
@property(nonatomic,assign) BOOL isShowCloseBtn;

///当type = SSnaviTypeShowOnlyPicture时的，中间图标对应的字段
@property(nonatomic,copy) NSString* centerImgStr;

///右侧按钮图标
@property(nonatomic,copy) NSString* rightBtnImgStr;

///0：左侧按钮；1：右侧按钮；2：紧挨着左侧按钮的关闭按钮，适用于webView的VC界面
@property(nonatomic,copy) SSNaviBtnsBLock naviBlock;
///搜索Block
@property(nonatomic,copy) void (^SSnaviSearchBlock) (NSString* text);

@end

NS_ASSUME_NONNULL_END
