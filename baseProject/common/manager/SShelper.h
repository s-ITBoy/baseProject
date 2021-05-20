//
//  SShelper.h
//  baseProject
//
//  Created by FL S on 2017/12/9.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 日期格式化类型
typedef NS_ENUM(NSUInteger, SSDateFormatterStyle){
    /// yyyy-MM-dd HH:mm:ss
    SSDateFormatterStyleDefault = 1,
    /// yyyy/MM/dd HH:mm:ss
    SSDateFormatterStyle_2,
    /// yyyyMMddHHmmss
    SSDateFormatterStyle_3,
    ///  yyyy-MM-dd
    SSDateFormatterStyle_4,
    /// yyyy年MM月dd日
    SSDateFormatterStyle_5,
    ///  yyyy/MM/dd HH:mm
    SSDateFormatterStyle_6,
    ///  HH:mm:ss
    SSDateFormatterStyle_7,
    ///  mm:ss
    SSDateFormatterStyle_8,
    ///  ss
    SSDateFormatterStyle_9,
    /// yyyy/MM/dd
    SSDateFormatterStyle_10,
    /// MM月dd日
    SSDateFormatterStyle_11,
    /// yyyyMMdd_HHmmss
    SSDateFormatterStyle_12,
    /// HHmmss
    SSDateFormatterStyle_13,
    /// yyyy.MM.dd HH:mm:ss
    SSDateFormatterStyle_14,
    /// MM-dd
    SSDateFormatterStyle_15,
    /// yyyyMMdd
    SSDateFormatterStyle_16,
};

NS_ASSUME_NONNULL_BEGIN

@interface SShelper : NSObject

///将时间戳转换成指定时间格式的字符串(当时间戳为13位时需除以1000)
+ (NSString*_Nullable)stringFromeTimeInterval:(NSString*_Nullable)timeStamp with:(SSDateFormatterStyle)type;
///将指定时间格式的时间字符串转成date
+ (NSDate*_Nullable)dateFromeTimeStr:(NSString*_Nullable)timeStr with:(SSDateFormatterStyle)type;
///将指定时间格式的时间字符串转成时间戳
+ (NSString*_Nullable)timeintervalStringFromeTimeString:(NSString*_Nullable)timeStr with:(SSDateFormatterStyle)type;
///将指定时间格式的时间字符串转成NSTimeInterval
+ (NSTimeInterval)timeintervalFromeTimeString:(NSString*_Nullable)timeStr with:(SSDateFormatterStyle)type;
///获取当前时间的时间戳
+ (NSTimeInterval)getCurrentTimeInterval;
///获取当前时间的时间戳字符串
+ (NSString*_Nullable)getCurrentTimeIntervalStr;


#pragma mark ----------- Create View ----------------
///创建Label
+(UILabel*_Nonnull)SSlabel:(UIFont*_Nullable)font textAlignment:(NSTextAlignment)alignment textColor:(UIColor*_Nullable)textColor backgroundColor:(UIColor*_Nullable)bgcolor;

///创建线条
+(UIView*_Nullable)SSline:(UIColor*_Nullable)bgColor;

///创建按钮（简单属性）
+(UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font;
///创建按钮（简单属性带有背景色）
+(UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor;
///创建按钮（简单属性带有背景图）
+(UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgImgStr:(NSString* _Nullable)imgStr;
///创建按钮（带有全面属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor selectedTitle:(NSString* _Nullable)selectTitle selectedColor:(UIColor* _Nullable)selectColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor bgImg:(NSString* _Nullable)bgimgStr;

///创建UITextField
+(UITextField*_Nullable)SStextField:(NSString*_Nullable)placeHolder andTextColor:(UIColor*_Nullable)textColor andFont:(UIFont*_Nullable)font;

///创建imageView
+ (UIImageView *)SSimgeView:(CGRect)frame imgName:(NSString* _Nullable)imgName;

///生成二维码
+ (UIImage*)SSgetQRcodeWithStr:(NSString*)str size:(CGFloat)size;

///截取指定视图的指定区域，传入需要截取的view和
+ (UIImage*_Nullable)SSscreenShot:(UIView *_Nullable)view;

#pragma mark ------ 小功能 -------
/// 判断对象是否为空，包括nil 空字符串、空字典、空数组等; YES:空；NO：非空
+(BOOL)isObjNil:(id _Nullable )obj;
///复制
+ (void)SScopyStr:(NSString*)str;
///打电话
+ (void)SScallPhone:(NSString*_Nullable)phoneNum;
///打开/跳转URL
+ (void)SSopenURL:(NSString*)urlStr;
///状态栏字体颜色(0:白色: 非0:黑色)
+ (void)SSstatusBarTextColor:(int)intValue;
/**
 图文混排
 @param str 文字
 @param color 文字颜色
 @param font 文字字号
 @param imageName 图片名
 @param isfront 图片是否在前面
 @param rect 图片的
 */
+ (NSMutableAttributedString*)SSattri:(NSString*)str Color:(UIColor*)color Font:(UIFont*)font andImageName:(NSString*)imageName isFront:(BOOL)isfront andRect:(CGRect)rect;
///获取当前屏幕显示的viewcontroller
+ (UIViewController *_Nullable)getCurrentVC;
///根据dic自动生成model属性
+ (void)SSautoPropertyWith:(NSDictionary*)dic;

#pragma mark ----------  弹框或跳转界面 ------------
///AlertActionSheet
+ (void)SSshowActionSheet:(NSArray<UIAlertAction *> *_Nullable)actions tips:(NSString *_Nullable)tips message:(NSString *_Nullable)message target:(UIViewController *_Nullable)target;

///跳转到对应H5界面
+ (void)SSintoH5:(UIViewController*_Nullable)viewController urlStr:(NSString*_Nullable)urlString;

///进入搜索界面
+ (void)SSintoSearchVC:(UIViewController*_Nullable)viewController;

///全屏展示图片
+ (void)SSshowImages:(NSArray*_Nullable)images index:(NSInteger)index currentVC:(UIViewController*_Nullable)currentVC;
///融云刷新用户数据
//+ (void)refreshRongCloud:(NSString*_Nullable)uid and:(NSString*_Nullable)name and:(NSString*_Nullable)imageUrl;

//+ (void)toSchemeUrl:(NSURL *_Nullable)url;

#pragma mark ------------- 正则表达式判断 ---------------
///数字或26个英文字母组成的字符串
+ (BOOL)isNUmAndEnglishAlphahet:(NSString*_Nullable)str;
///纯英文字母
+ (BOOL)isEnglishAlphabet:(NSString*_Nullable)Str;
///纯数字
+ (BOOL)isNum:(NSString*_Nullable)Str;
///身份证号YES：有效； NO：无效
+ (BOOL)isValidIdenditifyCard:(NSString*_Nullable)cardStr;
//邮箱YES：有效； NO：无效
+ (BOOL)isValidEmail:(NSString *_Nullable)email;
//手机号码YES：有效； NO：无效
+ (BOOL)isValidPhoneeNumber:(NSString *_Nullable)mobileNum;
///金额格式YES：有效； NO：无效
+ (BOOL)isValidMoney:(NSString*_Nullable)moneySr;
///银行卡号YES：有效； NO：无效
+(BOOL)isValidBankCard:(NSString *_Nullable)cardNumber;

///当前app名称
+ (NSString*_Nullable)ss_appName;
///当前app版本号（1.0.1）
+ (NSString*_Nullable)ss_versionForApp;

#pragma mark ------------- 当前设备信息 -------------
///系统版本号
+ (NSString*_Nullable)ss_getVersion;
///设备型号
+ (NSString *_Nullable)ss_getIphoneType;
///获取设备号(udid)
+ (NSString*)getDeviceNum;
///获取设备唯一广告标识符
+ (NSString*)SSgetDeviceADstr;


NSString* _Nullable SSformatDate(NSInteger timespace);
///金额格式
NSString* _Nullable SSformatMoney(id _Nullable money);


@end

NS_ASSUME_NONNULL_END
