//
//  SSuserModel.h
//  ddz
//
//  Created by F S on 2017/7/12.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSuserModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString* avatar_img;
@property(nonatomic,copy) NSString* idStr;
@property(nonatomic,copy) NSString* mobile;
///登录的设备号
@property(nonatomic,copy) NSString* device_number;
@property(nonatomic,copy) NSString* token;
@property(nonatomic,copy) NSString* nick_name;
@property(nonatomic,copy) NSString* real_name;
///邀请码
@property(nonatomic,copy) NSString* invitation_code;
@property(nonatomic,copy) NSString* user_code;
@property(nonatomic,copy) NSString* qrcode;
@property(nonatomic,copy) NSString* face_url;

@property(nonatomic,copy) NSString* wx_appid;
@property(nonatomic,copy) NSString* wx_openid;
///新增,用于判断是否绑定(空:没绑定,非空:绑定)
@property(nonatomic,copy) NSString* cooperate_key;
///新增,用于对接拼多多的推广位id
@property(nonatomic,copy) NSString* ddk_pid;
///单独接口新增:分享的图片的url
@property(nonatomic,copy) NSString* shareImgUrl;
///新增,淘宝的渠道id
@property(nonatomic,copy) NSString* relation_id;

+ (id)shareModel;
- (void)saveInfo;
- (void)deleteInfo;

+ (void)isLOginBLock:(void (^) (BOOL isLogin))loginBLock;

@end

NS_ASSUME_NONNULL_END
