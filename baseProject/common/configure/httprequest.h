//
//  httprequest.h
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//18565826853，1234560
// 13189720746
#ifndef httprequest_h
#define httprequest_h
#import <Foundation/Foundation.h>


#pragma  -- 服务器地址
///   http://www.lihvip.com              正式环境
///   http://www.test.lihvip.com         测试环境
///   http://192.168.1.88/mall           本地环境


#ifdef DEBUG
#define ServerHost @"https://pcapi.lihvip.com"
#define H5Host @"https://www.lihvip.com"
//#define ServerHost @"http://192.168.1.88:8082"
//#define ServerHost @"http://192.168.1.112:8082"r
//#define ServerHost @"http://pcapi.test.lihvip.com"
//#define H5Host @"http://www.test.lihvip.com"

#else

//#define ServerHost @"http://pcapi.test.lihvip.com"
//#define H5Host @"http://www.test.lihvip.com"
#define ServerHost @"https://pcapi.lihvip.com"
#define H5Host @"https://www.lihvip.com"

#endif


///正式环境的
#define Weichat_key   @"ASDADS21ads1a11asd132a1sd32ASSAD"
#define Weichat_Secret @"eb4e3c9056026698988f8efa60000ed7"
#define Weichat_appid @"wx6f95c0f38a8d05b6"


#pragma -------------接口URL----------------------
///检查更新
#define versionUrl           [ServerHost stringByAppendingString:@"/version.do"]
///订单中的客服电话
#define servicePhoneUrl      [ServerHost stringByAppendingString:@"/getCustomerServicePhone.do"]

///登录,注册及验证码接口URL
#define loginApiUrl           [ServerHost stringByAppendingString:@"/login.do"]
#define registerUrl            [ServerHost stringByAppendingString:@"/regUser.do"]
#define sendCodeUrl        [ServerHost stringByAppendingString:@"/sendCode.do"]
#define checkCodeUrl      [ServerHost stringByAppendingString:@"/checkCode.do"]
#define findPasswdUrl      [ServerHost stringByAppendingString:@"/findPasswd.do"]
#define quitOutUrl      [ServerHost stringByAppendingString:@"/user/logout.do"]

///修改密码，用户名，头像等
#define loginPasswdUrl      [ServerHost stringByAppendingString:@"/user/updatePasswd.do"]
#define userNameUrl          [ServerHost stringByAppendingString:@"/user/updateUserName.do"]
#define headImageUrl         [ServerHost stringByAppendingString:@"/user/updateHeadImg.do"]
#define tradPasswdUrl        [ServerHost stringByAppendingString:@"/user/setTradePasswd.do"]

#define uploadFileUrl          [ServerHost stringByAppendingString:@"/getUploadFileUrl.do"]

///消息
#define newsCenterUrl          [ServerHost stringByAppendingString:@"/user/newsCenter.do"]
#define newsUrl                     [ServerHost stringByAppendingString:@"/user/news.do"]
#define updateNewsUrl         [ServerHost stringByAppendingString:@"/user/updateNews.do"]
#define newsH5Url                [ServerHost stringByAppendingString:@"/user/newsH5.do"]


///收获地址相关接口
#define addrLIstUrl           [ServerHost stringByAppendingString:@"/user/address/all.do"]
#define addAddrUrl           [ServerHost stringByAppendingString:@"/user/address/save.do"]
#define setMorenUrl           [ServerHost stringByAppendingString:@"/user/address/setDefault.do"]
#define deleaddrUrl           [ServerHost stringByAppendingString:@"/user/address/del.do"]
///用户银行卡相关接口
#define bankCardListUrl           [ServerHost stringByAppendingString:@"/user/bankcard/all.do"]
#define allBankNameUrl           [ServerHost stringByAppendingString:@"/user/bankcard/allBankName.do"]
#define deleteBankCard           [ServerHost stringByAppendingString:@"/user/bankcard/del.do"]
#define addBankCardUrl           [ServerHost stringByAppendingString:@"/user/bankcard/save.do"]
///省市区地址接口
#define selecteAddrUrl           [ServerHost stringByAppendingString:@"/selectRegionAll.do"]
///我的钱包相关接口
#define walletHeadUrl           [ServerHost stringByAppendingString:@"/user/fund.do"]
#define useableListUrl           [ServerHost stringByAppendingString:@"/user/fundList.do"]
#define distribuListUrl           [ServerHost stringByAppendingString:@"/user/distributionLog.do"]
#define drawFreeUrl           [ServerHost stringByAppendingString:@"/user/withdrawFee.do"]
#define commisionUrl           [ServerHost stringByAppendingString:@"/user/getRoyLog.do"]
#define withDrawUrl           [ServerHost stringByAppendingString:@"/user/withdrawApply.do"]


///订单相关接口
#define orderListUrl               [ServerHost stringByAppendingString:@"/user/distributionLog.do"]
#define orderLogUrl               [ServerHost stringByAppendingString:@"/user/orderLog.do"]
#define orderDetailUrl           [ServerHost stringByAppendingString:@"/user/orderInfo.do"]
#define orderCancelUrl           [ServerHost stringByAppendingString:@"/user/applyCancel.do"]
#define deleteOrderUrl           [ServerHost stringByAppendingString:@"/user/deleteOrder.do"]
///申请售后
#define applyrefundUrl            [ServerHost stringByAppendingString:@"/user/applyRefund.do"]
#define saleAfterUrl            [ServerHost stringByAppendingString:@"/user/aftermarket/addAftermarket.do"]
#define refundListUrl            [ServerHost stringByAppendingString:@"/user/refundList.do"]
#define backMoneyUrl             [ServerHost stringByAppendingString:@"/user/refundInfo.do"]
///物流相关
#define selectLogisUrl             [ServerHost stringByAppendingString:@"/logisticsSelect.do"]
#define kuaiDiUrl             [ServerHost stringByAppendingString:@"/kuaidi100.do"]
#define addLogisUrl             [ServerHost stringByAppendingString:@"/user/aftermarket/addLogistics.do"]


#define orderReceiptUrl           [ServerHost stringByAppendingString:@"/user/confirmReceipt.do"]

#define createOrderUrl           [ServerHost stringByAppendingString:@"/user/createOrder.do"]
#define submitOrderUrl           [ServerHost stringByAppendingString:@"/user/submitOrder.do"]
#define submitOrderAgainUrl           [ServerHost stringByAppendingString:@"/user/againSubmitOrder.do"]

#define goodDiscountUrl           [ServerHost stringByAppendingString:@"/user/goodsDiscount.do"]
#define payOrderUrl                [ServerHost stringByAppendingString:@"/user/payOrder.do"]


///优惠券
#define couponListUrl                  [ServerHost stringByAppendingString:@"/user/coupon.do"]
#define canUseCouponUrl           [ServerHost stringByAppendingString:@"/goods/userCoupon.do"]



///活动列表
#define acitivityListUrl           [ServerHost stringByAppendingString:@"/bannerList.do"]
///商品列表
#define goodListUrl               [ServerHost stringByAppendingString:@"/goodsList.do"]
//一级分类（包括二级）
#define goodCategoryUrl            [ServerHost stringByAppendingString:@"/selectAllType.do"]
#define recommendUrl               [ServerHost stringByAppendingString:@"/selectRecommend.do"]

///购物车
#define shopCarListUrl               [ServerHost stringByAppendingString:@"/user/cart/getCartList.do"]
#define deleteCarUrl               [ServerHost stringByAppendingString:@"/user/cart/del.do"]
#define shopCarNumUrl               [ServerHost stringByAppendingString:@"/user/cart/size.do"]
#define editshopCarNumUrl           [ServerHost stringByAppendingString:@"/user/cart/editGoodsNum.do"]
#define shopCarEditSpecUrl          [ServerHost stringByAppendingString:@"/user/cart/edit.do"]


/// 首页数据
#define  homePageUrl              [ServerHost stringByAppendingString:@"/index.do"]
#define  announListUrl              [ServerHost stringByAppendingString:@"/announcement/list.do"]
#define  announDetailUrl              [ServerHost stringByAppendingString:@"/announcement/getInfo.do"]


//商品详情
#define  goodsDetailUrl           [ServerHost stringByAppendingString:@"/getGoods.do"]
//商品优惠券
#define  goodsCouponUrl           [ServerHost stringByAppendingString:@"/goods/goodsCoupon.do"]
//领取优惠券
#define  receiveCouponUrl(id)         [ServerHost stringByAppendingString:[NSString stringWithFormat:@"/goods/receiveCoupon/%@.do",id]]
//推荐商品
#define  RecommendUrl             [ServerHost stringByAppendingString:@"/selectRecommend.do"]
//加入购物车
#define  addShopingCar            [ServerHost stringByAppendingString:@"/user/cart/add.do"]
//获取购物车总记录
#define  getTotalNum              [ServerHost stringByAppendingString:@"/user/cart/size.do"]
//商品类型列表
#define goodsTypesUrl             [ServerHost stringByAppendingString:@"/goodsTypes.do"]
//商品分享
#define  ShareGoodsUrl            [ServerHost stringByAppendingString:@"/goods/userShareGoods.do"]
///商品规格/周期修改
#define editCarUrl                [ServerHost stringByAppendingString:@"/user/cart/edit.do"]


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
