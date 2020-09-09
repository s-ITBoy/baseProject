//
//  httprequest.h
//  leeMail
//
//  Created by F S on 2017/7/5.
//  Copyright © 2017 F S. All rights reserved.
//18565826853，1234560
// 13189720746
#ifndef httprequest_h
#define httprequest_h
#import <Foundation/Foundation.h>


#pragma  -- 服务器地址
// 本地服   http://192.168.10.61
// 测试服   http://beta.api.valentina-yz.com
// 正式服   http://api.antcong.com

#ifdef DEBUG
//#define ServerHost @"http://api.valentina-yz.com"
#define ServerHost @"http://beta.ddsc.api.valentina-yz.com"
//#define ServerHost @"https://api.cikarcia.com"
//#define ServerHost @"http://192.168.10.119:6010"
//#define ServerHost @"http://109.shopping.valentina-yz.com"
#define shareHost @"http://109.shopping.valentina-yz.com"
//#define ServerHost @"http://192.168.10.61/ws_project/ws_app_php/entry/index.php"
//#define shareHost @"http://192.168.10.61/ws_project/ws_app_php/entry"

#else

#define ServerHost @"http://api.valentina-yz.com"
//#define ServerHost @"http://beta.ddsc.api.valentina-yz.com"
//#define ServerHost @"http://192.168.10.119:6010"
#define shareHost @"http://109.shopping.valentina-yz.com"
//#define ServerHost @"http://192.168.10.61/ws_project/ws_app_php/entry/index.php"
//#define shareHost @"http://192.168.10.61/ws_project/ws_app_php/entry"

#endif


///正式环境的
#define Weichat_key   @"ASDADS21ads1a11asd132a1sd32ASSAD"
#define Weichat_Secret @"eb4e3c9056026698988f8efa60000ed7"
#define Weichat_appid @"wx6f95c0f38a8d05b6"





#pragma mark --------- 存储信息的相关字段 ---------
///token   hMQFA65kkB7IryhBDRYCdY14KTqVyjVTAcnfNzl1lVlWUappYzIwVw==
static NSString *token = @"token";
///手机号
static NSString *phoneNum = @"phone";
///登录密码
static NSString *passwd = @"passwd";
///是否设置交易密码
static NSString *isSetTradePw = @"isSetTradePw";
///省市区数组
static NSString *addressAreas = @"addressAreas";
///眼睛按钮，是否关闭；yes：关闭
static NSString *isClosedeye = @"isClosedeye";
///搜索记录
static NSString *searchArr = @"searchArr";
///订单中的客服电话
static NSString *servicePhone = @"servicePhone";

#endif /* httprequest_h */
