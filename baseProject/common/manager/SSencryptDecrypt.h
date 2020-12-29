//
//  SSencryptDecrypt.h
//  baseProject
//
//  Created by F S on 2017/12/29.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///加密/解密
@interface SSencryptDecrypt : NSObject

#pragma mark ------------ DES  对称加密解密 ----------------

/**
 * AES私钥加密
 * @param str 需要加密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)DES_encryptStr:(NSString*)str privateKey:(NSString*)privateKey;

/**
 * AES私钥解密
 * @param str 需要解密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)DES_decryptStr:(NSString*)str privateKey:(NSString*)privateKey;

#pragma mark ------------ AES  对称加密解密 ----------------

/**
 * AES私钥加密
 * @param str 需要加密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)AES_encryptStr:(NSString*)str privateKey:(NSString*)privateKey;

/**
 * AES私钥解密
 * @param str 需要解密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)AES_decryptStr:(NSString*)str privateKey:(NSString*)privateKey;

#pragma mark ------------ RSA 非对称加密解密 ----------------


/**
 * 公钥加密（默认使用公钥字符串）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str;
/**
 * 公钥加密（使用公钥字符串）
 * @param str 需要加密的str
 * @param publickey 公钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str publicKeyStr:(NSString*)publickey;

/**
 * 公钥加密（默认使用公钥文件）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptByFileForStr:(NSString*)str;

/**
 * 公钥加密（使用公钥文件）
 * @param str 需要加密的str
 * @param publickeyFilePath 公钥文件路径
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str publicKeyFilePath:(NSString*)publickeyFilePath;

/**
 * 私钥解密（默认使用私钥字符串）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str;

/**
 * 私钥解密（使用私钥字符串）
 * @param str 需要加密的str
 * @param privateKey 私钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str privateKeyStr:(NSString*)privateKey;

/**
 * 私钥解密（默认使用私钥文件）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptByFileForStr:(NSString*)str;

/**
 * 私钥解密（使用私钥文件）
 * @param str 需要加密的str
 * @param privateKeyFilePath 私钥文件路径
 * @param privateFilePassword 私钥文件密码
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str privateKeyFilePath:(NSString*)privateKeyFilePath password:(NSString*)privateFilePassword;

@end

NS_ASSUME_NONNULL_END
