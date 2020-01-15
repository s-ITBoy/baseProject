//
//  NSString+SS.m
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "NSString+SS.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>

@implementation NSString (SS)

///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font {
    return [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}
///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect.size;
}
///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(CGFloat)font2 with:(UIColor*)color2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font2] range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:secondRange];
    if ((secondRange.length + secondRange.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
    }
    
    return attriStri;
}

///MD5加密
- (NSString *)ss_MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

#pragma mark ------------- 当前应用qpp信息 --------
///当前app名称
+ (NSString*)ss_appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
///当前app版本号（1.0.1）
+ (NSString*)ss_versionForApp {
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  格式化金额字符串，小数点前每三位之间加,
 *
 *  @return 格式化后的字符串
 */
- (NSString *)formatMoneyString {
    if ([self empty]) {
        return @"0";
    }
    NSArray *range = [[self numberStringFromString] componentsSeparatedByString:@"."];
    NSString *str = range[0];
    NSMutableArray *nums = [NSMutableArray arrayWithCapacity:0];
    int j = 0;
    for (NSInteger i = str.length - 1; i >= 0 ; i--) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        j++;
        [nums insertObject:s atIndex:0];
        if (j == 3  && i > 0) {
            [nums insertObject:@"," atIndex:0];
            j = 0;
        }
    }
    
    NSString *result = [nums componentsJoinedByString:@""];
    if (range.count == 2) {
        result = [result stringByAppendingFormat:@".%@",range[1]];
    }
    return result;
}

///将url地址中所带的参数转换为字典 格式k1=v1&k2=v2
- (NSDictionary *)dictionaryFromString {
    NSArray *compents = [self componentsSeparatedByString:@"&"];
    if (!compents.count) {
        return [NSDictionary dictionary];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    for (id obj in compents) {
        if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj containsString:@"="]) {
            NSString *str = (NSString *)obj;
            NSArray *strs = [str componentsSeparatedByString:@"="];
            //            NSString *value = [[strs objectAtArrayIndex:1] empty] ? @"" : [strs objectAtArrayIndex:1];
            [params setObject:[strs SSobjectAtArrayIndex:1] forKey:[strs SSobjectAtArrayIndex:0]];
        }
    }
    return params;
}

/**
 *  格式化银行卡号 四位空格
 *
 *  @return 格式化后的字符串
 */
- (NSString *)bankCodeFormat {
    if ([self empty]) {
        return @"";
    }
    if (self.length <=4) {
        return self;
    }
    NSMutableArray *charaters = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.length; i++) {
        NSString *charater = [self substringWithRange:NSMakeRange(i, 1)];
        [charaters addObject:charater];
        if (i%4 == 3) {
            [charaters addObject:@" "];
        }
    }
    return [charaters componentsJoinedByString:@""];
}

/**
 格式化金额字符串，不足万的显示原值，反之处理成以万为单位
 
 @return <#return value description#>
 */
- (NSString *)formatAmount {
    if ([self empty]) {
        return @"0";
    }
    double value = self.doubleValue;
    double result = value/10000.0;
    if (result >= 1.0) {
        return [[[NSString stringWithFormat:@"%0.2f",result] numberStringFromString] stringByAppendingString:@"万元"];
    }
    return [[[NSString stringWithFormat:@"%0.2f",value] numberStringFromString] stringByAppendingString:@"元"];
}

/**
 去除字符串中的html标签
 
 @return 去除标签的字符串
 */
- (NSString *)stringByTrimmingHTMLCharacters {
    if ([self empty]){
        return @"";
    }
    NSRange r;
    NSString *s = [[self stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


/**
 *  格式化数字字符串，保留两位小数，并去除末尾的0
 *
 *  @return 格式化之后的字符串
 */
-(NSString *)numberStringFromString {
    
    if (!self || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return self;
    }
    NSNumberFormatter *format = [NSNumberFormatter new];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [format numberFromString:self];
    NSString *str = [NSString stringWithFormat:@"%0.2f",num.doubleValue];
    NSRange range = [str rangeOfString:@"."];
    if (range.location == !NSNotFound) {
        return self;
    }
    //去除末尾的0，获取剪切位置
    NSInteger loc = str.length ;
    for (NSInteger i = str.length - 1; i > range.location; i--) {
        int a = [str characterAtIndex:i];
        if (a == 48) {
            loc--;
        }else{
            break;
        }
    }
    str = [str substringToIndex:loc];
    //如果末尾为.去除末尾的.
    if ([str rangeOfString:@"."].location == str.length - 1) {
        return [str substringToIndex:str.length - 1];
    }
    return str;
}

- (BOOL)empty {
    if (!self || [self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }
    return NO;
}

@end
