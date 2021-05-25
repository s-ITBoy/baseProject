//
//  SSshareManager.h
//  ddz
//
//  Created by F S on 2017/12/17.
//  Copyright © 2017 F S. All rights reserved.
//手动接入WechatSDK1.8.7.1(包含微信支付) 需要手动导入系统的一些相关库
/*
 Security.framework
 CoreGraphics.framework
 CoreTelephony.framework
 WebKit.framework
 SystemConfiguration.framework
 libz.tbd
 libsqlite3.0.tbd
 libc++.tbd
 */

#import <Foundation/Foundation.h>
///导入微信SDK即可使用
//#import "WXApi.h"

///分享模型
@interface SSshareModel : NSObject
///<WXApiDelegate>

///标题
@property(nonatomic,strong) NSString* _Nullable title;
///描述
@property(nonatomic,strong) NSString* _Nullable descript;
///多媒体数据对象类型(0:网页类;1:图片类...
@property(nonatomic,assign) NSInteger type;
///网页链接
@property(nonatomic,strong) NSString* _Nullable webUrlStr;
///图片的二进制文件
@property(nonatomic,strong) NSData* _Nullable thumbData;
///右侧//logo图标名
//@property(nonatomic,strong) NSString* _Nullable logo;

///0：微信好友； 1：微信朋友圈； 2：微博； 3：qq; ...
@property(nonatomic,assign) NSInteger shareToWhere;

@end

NS_ASSUME_NONNULL_BEGIN
///分享f管理类
@interface SSshareManager : NSObject
///<WXApiDelegate>

+ (instancetype)sharemanager;

- (void)SSsharecontent:(SSshareModel*)model and:(void(^) (BOOL isSuccess, NSString* msg))callBackBlock;

@end



NS_ASSUME_NONNULL_END
