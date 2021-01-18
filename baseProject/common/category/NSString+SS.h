//
//  NSString+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SS)
///MD5加密
- (NSString *)ss_MD5String;
///sha1加密
- (NSString*)ss_sha1;

///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font;
///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font;
///设置不同的颜色
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 color:(UIColor*)color1 range:(NSRange)range2 color:(UIColor*)color2;
///设置不同的字号
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 font:(UIFont*)font1 range:(NSRange)range2 font:(UIFont*)font2;
///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange andFont:(CGFloat)font2 with:(UIColor*)color2;


///字符串转字典
- (NSDictionary *)ss_dicFromStr;

///字符串转数组;str:字符串中的分割符（比如：, - 等等）
- (NSArray*)ss_arrFromStrByStr:(NSString*)str;


///格式化金额字符串，小数点前每三位之间加,
- (NSString *)ss_moneyStr;

///格式化银行卡号 四位空格
- (NSString *)ss_bankCodeStr;

///格式化金额字符串，不足万的显示原值，反之处理成以万为单位
- (NSString *)ss_amountStr;

///去除字符串中的html标签
- (NSString *)ss_stringByTrimmingHTMLCharacters;

/**
 *  生成助记字符串
 *  strlength   指定的长度
 *  language    指定的语言 如：english 文件地址    english.txt 支持：简体中文、繁体中文、英文、法文、意大利文、日文、韩文、西班牙文
 */
+ (NSString*)SS_getMnemonicStr:(NSNumber*)strLength language:(NSString*)language;

///十六进制str转data
- (NSData*)SS_hexStrToData;

#pragma mark ----------- base58 ---------------
@property(nonatomic,strong) NSString* base58codeStr;
@property(nonatomic,strong) NSMutableDictionary* base58codeMuDic;

// base58加密， 传入加密前的字符串
- (NSString *)SS_base58Encode;
// base58解密， 传入加密后的字符串
- (NSString *)SS_base58Decode;

#pragma mark ----------- SHA ---------------
- (NSString*)SS_sha256Str;
- (NSString*)SS_sha512Str;

@end

