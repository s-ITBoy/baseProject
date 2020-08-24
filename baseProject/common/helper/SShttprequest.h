//
//  SShttprequest.h
//  leeMail
//
//  Created by F S on 2017/7/5.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
/**
 网络请求方式
 - HttpRequestMethodGet: get
 - HttpRequestMethodPost: post
 - HttpRequestMethodUPLOAD: 图片上传
 */
typedef NS_ENUM(NSUInteger, HttpRequestMethod) {
    HttpRequestMethodGet,
    HttpRequestMethodPost,
    HttpRequestMethodUPLOAD,
};
@interface SShttprequest : NSObject

+ (SShttprequest*)shareRequest;

- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method  showLoading:(BOOL)showLoading showFailure:(BOOL)show resultHandler:(void(^)(BOOL isOK, id responseOnject))handler;


///上传图片（获取图片对应的path值）
- (void)uploadPhoto:(NSDictionary *)parameters urlString:(NSString *)urlString pictureData:(NSData*)pictureData name:(NSString *)name handler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id  error))failtureHandler;

///第三方微信登录所需要调用的接口(获取微信的openid和access_token等信息)
- (void)getwxLoginWithUrl:(NSString*)url result:(void(^)(BOOL isSucc, id responseOnject))handler;

///检查App Store中的版本
- (void)appstoreVersionCheck:(void(^)(id responseOnject))handler;

@end

NS_ASSUME_NONNULL_END
