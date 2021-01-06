//
//  NSData+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SS)
#pragma ------------base64--------------
///字符串转NSdata
+ (NSData *)SSdataWithBase64EncodedStr:(NSString *)str;
- (NSString *)SSbase64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
///NSData转字符串
- (NSString *)SSbase64EncodedStr;

///转成16进制字符串
- (NSString*)SS_hexStr;
///转成比特数组
- (NSArray*)SS_toBitArray;
@end

