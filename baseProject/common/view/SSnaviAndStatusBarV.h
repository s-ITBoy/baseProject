//
//  SSnaviAndStatusBarV.h
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSNaviBtnsBLock)(NSInteger index);

@interface SSnaviAndStatusBarV : UIView
///导航栏标题
@property(nonatomic,strong) NSString* titleStr;
///左侧按钮角标
@property(nonatomic,strong) NSString* badgeNum;
///左侧返回按钮图标，默认为黑色的图标
@property(nonatomic,strong) NSString* leftbtnImgStr;
///左侧按钮默认显示
@property(nonatomic,assign) BOOL leftHIdden;
///右侧按钮图标
@property(nonatomic,strong) NSString* rightBtnImgStr;
///右侧按钮默认隐藏
@property(nonatomic,assign) BOOL isHiddenrightBtn;

///0：左侧按钮；1：右侧按钮
@property(nonatomic,copy) SSNaviBtnsBLock naviBlock;
@end

NS_ASSUME_NONNULL_END
