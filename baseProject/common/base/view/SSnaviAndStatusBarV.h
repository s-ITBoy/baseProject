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
@property(nonatomic,strong) NSString* badgeNum;
@property(nonatomic,strong) NSString* titleStr;

@property(nonatomic,assign) BOOL leftHIdden;

///0：左侧按钮；1：右侧按钮
@property(nonatomic,copy) SSNaviBtnsBLock naviBlock;
@end

NS_ASSUME_NONNULL_END
