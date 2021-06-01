//
//  NSString+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
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

#pragma mark --------- 对string做特性处理，并返回NSMutableAttributedString --------
///设置不同的颜色
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 color:(UIColor*)color1 range:(NSRange)range2 color:(UIColor*)color2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    if ((range2.length + range2.location) < self.length) {
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(range2.location+range2.length, self.length-range2.location-range2.length)];
    }
    
    return attriStri;
}
///设置不同的字号
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 font:(UIFont*)font1 range:(NSRange)range2 font:(UIFont*)font2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:font1 range:range1];
    [attriStri addAttribute:NSFontAttributeName value:font2 range:range2];
    if ((range2.length + range2.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(range2.location+range2.length, self.length-range2.location-range2.length)];
    }
    
    return attriStri;
}

///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange andFont:(CGFloat)font2 with:(UIColor*)color2 {
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
///给字符串添加下划线
- (NSMutableAttributedString*)SS_addLine {
    return [self SS_addLineWithRange:NSMakeRange(0, self.length)];
}
///给字符串中指定位置添加下划线
- (NSMutableAttributedString*)SS_addLineWithRange:(NSRange)range {
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:self];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    return str;
}

#pragma mark --------- 对string做格式处理 -----------
///将url地址中所带的参数转换为字典 格式k1=v1&k2=v2
- (NSDictionary*)ss_dicFromStr {
    NSArray* compents = [self componentsSeparatedByString:@"&"];
    if (!compents.count) {
        return [NSDictionary dictionary];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    for (id obj in compents) {
        if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj containsString:@"="]) {
            NSString* str = (NSString*)obj;
            NSArray* strs = [str componentsSeparatedByString:@"="];
            //            NSString *value = [[strs objectAtArrayIndex:1] empty] ? @"" : [strs objectAtArrayIndex:1];
            [params setObject:[strs SSobjectAtArrayIndex:1] forKey:[strs SSobjectAtArrayIndex:0]];
        }
    }
    return params;
}

///字符串转数组;str:字符串中的分割符（比如：, - 等等）
- (NSArray*)ss_arrFromStrByStr:(NSString*)str {
    NSArray* array = [self componentsSeparatedByString:str];
    return array;
}


///格式化金额字符串，小数点前每三位之间加,
- (NSString*)ss_moneyStr {
    if ([self empty]) {
        return @"0";
    }
    NSArray* range = [[self ss_numStr] componentsSeparatedByString:@"."];
    NSString* str = range[0];
    NSMutableArray* nums = [NSMutableArray arrayWithCapacity:0];
    int j = 0;
    for (NSInteger i = str.length - 1; i >= 0 ; i--) {
        NSString* s = [str substringWithRange:NSMakeRange(i, 1)];
        j++;
        [nums insertObject:s atIndex:0];
        if (j == 3  && i > 0) {
            [nums insertObject:@"," atIndex:0];
            j = 0;
        }
    }
    
    NSString* result = [nums componentsJoinedByString:@""];
    if (range.count == 2) {
        result = [result stringByAppendingFormat:@".%@",range[1]];
    }
    return result;
}

///格式化银行卡号 四位空格
- (NSString *)ss_bankCodeStr {
    if ([self empty]) {
        return @"";
    }
    if (self.length <=4) {
        return self;
    }
    NSMutableArray* charaters = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.length; i++) {
        NSString* charater = [self substringWithRange:NSMakeRange(i, 1)];
        [charaters addObject:charater];
        if (i%4 == 3) {
            [charaters addObject:@" "];
        }
    }
    return [charaters componentsJoinedByString:@""];
}

///格式化金额字符串，不足万的显示原值，反之处理成以万为单位
- (NSString*)ss_amountStr {
    if ([self empty]) {
        return @"0";
    }
    double value = self.doubleValue;
    double result = value/10000.0;
    if (result >= 1.0) {
        return [[[NSString stringWithFormat:@"%0.2f",result] ss_numStr] stringByAppendingString:@"万元"];
    }
    return [[[NSString stringWithFormat:@"%0.2f",value] ss_numStr] stringByAppendingString:@"元"];
}

///去除字符串中的html标签
- (NSString*)ss_stringByTrimmingHTMLCharacters {
    if ([self empty]){
        return @"";
    }
    NSRange r;
    NSString* s = [[self stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(NSString*)ss_numStr {
    
    if (!self || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return self;
    }
    
    NSNumberFormatter* format = [[NSNumberFormatter alloc] init];
//    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* num = [format numberFromString:self];
//    NSString *str = [NSString stringWithFormat:@"%0.2f",num.doubleValue];
//    NSRange range = [str rangeOfString:@"."];
//    if (range.location == !NSNotFound) {
//        return self;
//    }
//    //去除末尾的0，获取剪切位置
//    NSInteger loc = str.length ;
//    for (NSInteger i = str.length - 1; i > range.location; i--) {
//        int a = [str characterAtIndex:i];
//        if (a == 48) {
//            loc--;
//        }else{
//            break;
//        }
//    }
//    str = [str substringToIndex:loc];
//    //如果末尾为.去除末尾的.
//    if ([str rangeOfString:@"."].location == str.length - 1) {
//        return [str substringToIndex:str.length - 1];
//    }
    return [NSString stringWithFormat:@"%@",num];
}

- (BOOL)empty {
    if (!self || [self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }
    return NO;
}

/**
 *  生成助记字符串
 *  strlength   指定的长度
 *  language    指定的语言 如：english 文件地址    english.txt 支持：简体中文、繁体中文、英文、法文、意大利文、日文、韩文、西班牙文
 */
+ (NSString*)SS_getMnemonicStr:(NSNumber*)strLength language:(NSString*)language {
    if ([strLength integerValue] % 32 != 0) {
        [NSException raise:@"Strength must be divisible by 32" format:@"Strength Was: %@",strLength];
    }
    NSMutableData* bytes = [NSMutableData dataWithLength:[strLength integerValue] / 8];
    //生成随机data
    int status = SecRandomCopyBytes(kSecRandomDefault, bytes.length, bytes.mutableBytes);
    if (status == 0) {
        NSString* hexStr = [bytes SS_hexStr];
        return [self SS_getMnemonicWordFromeHexStr:hexStr language:language];
    }else {
        [NSException raise:@"Unable to get random data!" format:@"Unable to get random data!"];
    }
    
    return nil;
}

/**
 *  16进制字符串生成助记词
*/
+ (NSString*)SS_getMnemonicWordFromeHexStr:(NSString*)hexStr language:(NSString*)language {
    NSData* seedData = [hexStr SS_hexStrToData];
    //计算 sha256 哈希
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(seedData.bytes, (int)seedData.length, hash.mutableBytes);
    
    NSMutableArray* checkSumBits = [NSMutableArray arrayWithArray:[[NSData dataWithData:hash] SS_toBitArray]];
    NSMutableArray* seedBits = [NSMutableArray arrayWithArray:[seedData SS_toBitArray]];
    
    for(int i = 0 ; i < (int)seedBits.count / 32 ; i++) {
        [seedBits addObject:checkSumBits[i]];
    }
    
    NSString* path = [NSString stringWithFormat:@"%@/%@.txt",[[NSBundle mainBundle] bundlePath], language];
    NSString* fileText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray* lines = [fileText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray* words = [NSMutableArray arrayWithCapacity:(int)seedBits.count / 11];
    
    for(int i = 0 ; i < (int)seedBits.count / 11 ; i++) {
        NSUInteger wordNumber = strtol([[[seedBits subarrayWithRange:NSMakeRange(i * 11, 11)] componentsJoinedByString:@""] UTF8String], NULL, 2);
        
        [words addObject:lines[wordNumber]];
    }
    
    return [words componentsJoinedByString:@" "];
}


- (NSData*)SS_hexStrToData {
    const char* chars = [self UTF8String];
    int i = 0, len = (int)self.length;
    
    NSMutableData* data = [NSMutableData dataWithCapacity:len/2.0];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

#pragma mark ----------- MD5加密 ----------------

///MD5加密
- (NSString*)ss_MD5String {
    const char* cstr = [self UTF8String];
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

#pragma mark ----------- base58 ---------------

#define base58codeStr @"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

- (NSMutableDictionary*)base58codeMuDic {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        for(int i = 0; i< [base58codeStr length]; i++) {
            NSString* temp = [base58codeStr substringWithRange:NSMakeRange(i,1)];
            [dic addEntriesFromDictionary:@{ temp: @(i) }];
        }
    return dic;
}

// base58加密， 传入加密后的字符串
- (NSString*)SS_base58Encode {
    if (self.length == 0) {
        return @"";
    }
    NSArray* byteArr = [self UTF8ArrayWithString:self]; // aa真棒66 ==> [97, 97, 231, 156, 159, 230, 163, 146, 54, 54]
    if (byteArr.count <= 0) {
        return @"";
    }
    
    int BASE = 58;
    NSMutableArray* digits = [@[@(0)] mutableCopy];
    
    for (int i = 0; i < byteArr.count; i++) {
        for (int j = 0; j < digits.count; j++) {
            // 将数据转为二进制，再位运算右边添8个0，得到的数转二进制
            // 位运算-->相当于 digits[j].toString(2);parseInt(10011100000000,2)
            digits[j] = @([digits[j] intValue] << 8);
        }
        digits[0] = @([digits[0] intValue] + [byteArr[i] intValue]);
        
        int carry = 0;
        for (int j = 0; j < digits.count; ++j) {
            digits[j] = @([digits[j] intValue] + carry);
            carry = ([digits[j] intValue] / BASE) | 0;
            digits[j] = @([digits[j] intValue] % BASE);
        }
        while (carry) {
            [digits addObject:@(carry % BASE)];
            carry = (carry / BASE) | 0;
        }
        //处理前导为零的
        for (int i = 0; byteArr[i] == 0 && i < byteArr.count - 1; i++) {
            [digits addObject:@(0)];
        }
    }
//    NSLog(@"%@", digits); // aa真棒66 ==> [20, 23, 57, 15, 5, 18, 32, 28, 53, 35, 49, 18, 27, 5]
    // 最后，反序取ALPHABET_MAP，再拼起来
    NSString* result = @"";
    for (NSInteger k = digits.count - 1; k >= 0 ; k --) {
        NSString* value = [base58codeStr substringWithRange:NSMakeRange([digits[k] intValue],1)];;
        result = [result stringByAppendingString:value];
    }
//    NSLog(@"加密后 == %@", result); // aa真棒66 ==> 6UKrcvVZK6GzQM
    return result;
}

// 将字符串转utf8格式的字节数组（英文和数字直接返回的acsii码，中文转%xx之后打断当成16进制转10进制）
- (NSArray*)UTF8ArrayWithString:(NSString*)str {
    
    // NSString *tempaaa = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    // NSLog(@"看看== %@", tempaaa); // aa真棒66 ==> aa%E7%9C%9F%E6%A3%9266
    NSMutableArray* resultArr = [NSMutableArray array];
    for (int i = 0; i < [str length]; i++) {
        NSString* temp = [str substringWithRange:NSMakeRange(i,1)];
        NSString* charact = [temp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
        if (charact.length == 1) {
            // 未转换的字符，换为ASCII码
            [resultArr addObject:@([charact characterAtIndex:0])];
        } else {
            // 转换成%XX形式的字符, 拿到XX 16进制转为10进制
            NSArray* bytes = [charact componentsSeparatedByString:@"%"];
            for (int l = 1; l < bytes.count; l++) {
                [resultArr addObject:@(strtoul([bytes[l] UTF8String], 0, 16))]; // 16转为10
            }
        }
    }
//    NSLog(@"加密byte数组 == %@", resultArr); // aa真棒66 ==> [97, 97, 231, 156, 159, 230, 163, 146, 54, 54]
    return resultArr;
}

// base58解密， 传入加密后的字符串
- (NSString*)SS_base58Decode {
    if (self.length == 0) {
        return @"";
    }
    int BASE = 58;
    NSMutableArray *bytes = [@[@(0)] mutableCopy];
    for (int i = 0; i < [self length]; i++) {
        NSString* ch = [self substringWithRange:NSMakeRange(i,1)];
        // 判断ch是不是ALPHABET当中的字符
        if (![self containsString:ch]) {
            //NSLog(@"异常了 - base58不包含字符: %@", ch);
            return @"";
        }
        for (int j = 0; j < bytes.count; j++) {
            bytes[j] = @([bytes[j] intValue] * BASE);
        }
        bytes[0] = @([bytes[0] intValue] + [[self.base58codeMuDic objectForKey:ch] intValue]);
        int carry = 0;
        for (int j = 0; j < bytes.count; j++) {
            bytes[j] = @([bytes[j] intValue] + carry);
            carry = [bytes[j] intValue] >> 8;
            bytes[j] = @([bytes[j] intValue] & 0xff); // 255 == 0xff == 11111111
        }
        while (carry) {
            [bytes addObject:@(carry & 0xff)];
            carry >>= 8;
        }
    }
    //处理前导为零的
    for (int i = 0; [[self substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"1"] && i < [self length] - 1; i++) {
        [bytes addObject:@(0)];
    }
    // 数组翻转一下顺序
    bytes = [[[bytes reverseObjectEnumerator] allObjects] mutableCopy];
//    NSLog(@"解密byte数组 == %@", bytes); // 6UKrcvVZK6GzQM ==> [97, 97, 231, 156, 159, 230, 163, 146, 54, 54]
    
    NSString* result = [self byteToString:bytes]; // 6UKrcvVZK6GzQM ==> aa真棒66
    return result;
}

// 将字节数组解密成字符串
- (NSString*)byteToString:(NSArray *)arr {
    NSString* str = @"";
    for (int i = 0; i < arr.count; i++) {
        // 数组中每个数字转为二进制, 再匹配出开头为1的直到0的字符
        // eg:123-->"1111011"-->{0:"1111",groups: undefined, index: 0, input: "1111011"}
        NSString* hex2Str = [self hex10ToHex2: [arr[i] intValue]]; // 转为二进制
        NSString* v = [self get1To0End:hex2Str]; // 取开头为1的直到0的字符
        if (v.length > 0 && hex2Str.length == 8) {
            int bytesLen = (int)v.length;
            NSString *store = [hex2Str substringFromIndex:(7 - bytesLen)];
            for (int st = 1; st < bytesLen; st++) {
                NSString *sto1 = [[self hex10ToHex2: [arr[st+i] intValue]] substringFromIndex:2];
                store = [store stringByAppendingString:sto1];
            }
            // 2进制store 转为10进制ascii，再拼接到字符串
            int ascii = (int)strtoul([store UTF8String], 0, 2);
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%C", (unichar)ascii]];
            i += bytesLen - 1;
            
        } else {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%C", (unichar)[arr[i] intValue]]];
        }
    }
//    NSLog(@"解密后 == %@", str); // aa真棒66
    return str;
}

// 取出开头为1的直到0的字符, 1111011 -> 1111
- (NSString*)get1To0End:(NSString *)string {
    NSString* str = @"";
    for (int i = 0; i < string.length; i++) {
        NSString* ch = [string substringWithRange:NSMakeRange(i, 1)];
        if ([ch isEqualToString:@"0"]) {
            break;
        } else {
            str = [str stringByAppendingString:@"1"];
        }
    }
    return str;
}

// 十进制转为二进制
- (NSString*)hex10ToHex2:(int)hexInt {
    NSString* string = [NSString string];
    for (int i = 0; i <= 100; i++) {
        // 从后面算起。关键在取余
        int hex = hexInt % 2; // 每次的余数得到最后一位
        hexInt = hexInt / 2;
        if (hex > 0 || hexInt > 0) {
            NSString *str = @(hex).stringValue;
            string = [NSString stringWithFormat:@"%@%@", str, string]; // 要拼在前面。
        }
        if (hexInt <= 0) {
            break;
        }
    }
    return string;
}

#pragma mark ----------- SHA ---------------

///sha1加密
- (NSString*)ss_sha1 {
    const char* cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];

    NSData* data = [NSData dataWithBytes:cstr length:self.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)SS_sha256Str {
    const char* cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)SS_sha512Str {
    const char* cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
