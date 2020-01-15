//
//  NSString+SS.h
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SS)

///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font;
///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font;
///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(CGFloat)font2 with:(UIColor*)color2;

///MD5加密
- (NSString *)ss_MD5String;

#pragma mark ------------- 当前应用qpp信息 --------
///当前app名称
+ (NSString*)ss_appName;
///当前app版本号（1.0.1）
+ (NSString*)ss_versionForApp;

/**
 *  格式化金额字符串，小数点前每三位之间加,
 *
 *  @return 格式化后的字符串
 */
- (NSString *)formatMoneyString;


- (NSDictionary *)dictionaryFromString;
/**
 *  格式化银行卡号 四位空格
 *
 *  @return 格式化后的字符串
 */
- (NSString *)bankCodeFormat;

/**
 格式化金额字符串，不足万的显示原值，反之处理成以万为单位
 
 @return <#return value description#>
 */
- (NSString *)formatAmount;

/**
 去除字符串中的html标签
 
 @return 去除标签的字符串
 */
- (NSString *)stringByTrimmingHTMLCharacters;

@end

