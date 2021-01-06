//
//  NSData+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "NSData+SS.h"

@implementation NSData (SS)

+ (NSData *)SSdataWithBase64EncodedStr:(NSString *)str {
    if (![str length]) return nil;
    
    NSData *decoded = nil;
    
#if /*__MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 ||*/ __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    NSLog(@"%d",__IPHONE_OS_VERSION_MIN_REQUIRED);
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)]) {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
#endif
    {
        decoded = [[self alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)SSbase64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)]) {
        encoded = [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else
#endif
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length]) {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth) {
        if (i + wrapWidth >= [encoded length]) {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)SSbase64EncodedStr {
    return [self SSbase64EncodedStringWithWrapWidth:0];
}

///转成16进制字符串
- (NSString*)SS_hexStr {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    //如果buffer不存在
    if(!dataBuffer) {
        return [NSString string];
    }
    NSUInteger dataLength = [self length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for(int i = 0 ; i < dataLength ; ++i) {
        [hexString appendString:[NSString stringWithFormat:@"%02lx",(unsigned long)dataBuffer[i]]];
    }
    
    return [NSString stringWithString:hexString];
}

///转成比特数组
- (NSArray*)SS_toBitArray {
    NSMutableArray *bitArray = [NSMutableArray arrayWithCapacity:(int)self.length * 8];
    NSString *hexStr = [self SS_hexStr];
    
    for(NSUInteger i = 0 ; i < [hexStr length] ; i++) {
        NSString *bin = [self SS_hexToBinary:[hexStr characterAtIndex:i]];
        
        for(NSUInteger j = 0 ; j < bin.length ; j++) {
            [bitArray addObject:@([[NSString stringWithFormat:@"%C",[bin characterAtIndex:j]] intValue])];
        }
    }
    
    return [NSArray arrayWithArray:bitArray];
}

- (NSString *)SS_hexToBinary:(unichar)value {
    switch (value) {
        case '0': return @"0000";
        case '1': return @"0001";
        case '2': return @"0010";
        case '3': return @"0011";
        case '4': return @"0100";
        case '5': return @"0101";
        case '6': return @"0110";
        case '7': return @"0111";
        case '8': return @"1000";
        case '9': return @"1001";
        case 'a':
        case 'A':
            return @"1010";
        case 'b':
        case 'B':
            return @"1011";
        case 'c':
        case 'C':
            return @"1100";
        case 'd':
        case 'D':
            return @"1101";
        case 'e':
        case 'E':
            return @"1110";
        case 'f':
        case 'F':
            return @"1111";
    }
    return @"-1";
}

@end
