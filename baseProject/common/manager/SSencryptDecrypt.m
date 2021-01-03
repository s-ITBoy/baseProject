//
//  SSencryptDecrypt.m
//  baseProject
//
//  Created by F S on 2017/12/29.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSencryptDecrypt.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation SSencryptDecrypt

static NSString* base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData* base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}


#pragma mark ------------ DES  对称加密解密 ----------------
const Byte iv[] = {1,2,3,4,5,6,7,8};

/**
 * AES私钥加密
 * @param str 需要加密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)DES_encryptStr:(NSString*)str privateKey:(NSString*)privateKey {
    NSData* data;
    NSString* ciphertext = nil;
    NSData* textData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesEncrypted =0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding| kCCOptionECBMode ,
                                          [privateKey UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer,1024,
                                          &numBytesEncrypted);
    if(cryptStatus ==kCCSuccess) {
        data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        //加密后的data转换成64位，解密的时候需要用initWithBase64EncodedString方法转为data
        ciphertext = [data base64EncodedStringWithOptions:0];
    }
    return ciphertext;
}

/**
 * AES私钥解密
 * @param str 需要解密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)DES_decryptStr:(NSString*)str privateKey:(NSString*)privateKey {
    //加密后的data转换成64位，解密的时候需要用initWithBase64EncodedString方法转为data
    NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString* plaintext =nil;
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesDecrypted =0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [privateKey UTF8String],kCCKeySizeDES,
                                          iv,
                                          [data bytes],
                                          [data length],
                                          buffer,1024,
                                          &numBytesDecrypted);
    if(cryptStatus ==kCCSuccess){
        NSData* plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

#pragma mark ------------ AES  对称加密解密 ----------------

/**
 * AES私钥加密
 * @param str 需要加密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)AES_encryptStr:(NSString*)str privateKey:(NSString*)privateKey {
//    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData* data = base64_decode(str);
    
    NSData* encryData = [self AES128_Encrypt:privateKey encryptData:data];
//    NSString* output = [encryData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString* output = base64_encode_data(encryData);
    return output;
}

+ (NSData *)AES128_Encrypt:(NSString *)key encryptData:(NSData *)data {
    ///kCCKeySizeAES128可更换为256位加密 对应的解密也需要换成与之对应
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

//    char ivPtr[kCCKeySizeAES128+1];
//    bzero(ivPtr, sizeof(ivPtr));
//    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding| kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

/**
 * AES私钥解密
 * @param str 需要解密的str
 * @param privateKey 秘钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)AES_decryptStr:(NSString*)str privateKey:(NSString*)privateKey {
    NSData* data = base64_decode(str);
    NSData* encryptData =  [self AES128_Decrypt:privateKey encryptData:data];
//    NSString* output = [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
    NSString* output = base64_encode_data(encryptData);
    return output;
}

+ (NSData *)AES128_Decrypt:(NSString *)key encryptData:(NSData *)data {
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
//    char ivPtr[kCCKeySizeAES128+1];
//    bzero(ivPtr, sizeof(ivPtr));
//    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding| kCCOptionECBMode,keyPtr,kCCBlockSizeAES128,NULL,[data bytes],dataLength,buffer,bufferSize,&numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

#pragma mark ------------ RSA 非对称加密解密 ----------------
static NSString* RSA_publicKey() {
    return @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
}

static NSString* RSA_privateKey() {
    return @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";
}

static NSString* RSA_publicKeyFilePath() {
    return [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
}

static NSString* RSA_privateKeyFilePath() {
    return [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
}

static NSString* RSA_privateKeyFilePassword() {
    return @"";
}

/**
 * 公钥加密（默认使用公钥字符串）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str {
    NSData* data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:RSA_publicKey()];
//    NSString* ret = base64_encode_data(data);
    return base64_encode_data(data);
}

/**
 * 公钥加密（使用公钥字符串）
 * @param str 需要加密的str
 * @param publickey 公钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str publicKeyStr:(NSString*)publickey {
    NSData* data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:publickey];
//    NSString* ret = base64_encode_data(data);
    return base64_encode_data(data);
}

/**
 * 公钥加密（默认使用公钥文件）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptByFileForStr:(NSString*)str {
    if (!str || !RSA_publicKeyFilePath()) return nil;
    return [self encryptStr:str publicKeyRef:[self getPublicKeyRefWithContentsOfFile:RSA_publicKeyFilePath()]];
}

/**
 * 公钥加密（使用公钥文件）
 * @param str 需要加密的str
 * @param publickeyFilePath 公钥文件路径
 * @return 返回加密后的str
 */
+ (NSString*)RSA_encryptStr:(NSString*)str publicKeyFilePath:(NSString*)publickeyFilePath {
    if (!str || !publickeyFilePath) return nil;
    return [self encryptStr:str publicKeyRef:[self getPublicKeyRefWithContentsOfFile:publickeyFilePath]];
}

/**
 * 私钥解密（默认使用私钥字符串）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str {
    if (!str) return nil;
//    NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* data = base64_decode(str);
    data = [self decryptData:data privateKey:RSA_privateKey()];
//    NSString* ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
}

/**
 * 私钥解密（使用私钥字符串）
 * @param str 需要加密的str
 * @param privateKey 私钥字符串
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str privateKeyStr:(NSString*)privateKey {
    if (!str) return nil;
//    NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* data = base64_decode(str);
    data = [self decryptData:data privateKey:privateKey];
//    NSString* ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
}

/**
 * 私钥解密（默认使用私钥文件）
 * @param str 需要加密的str
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptByFileForStr:(NSString*)str {
    if (!str || !RSA_privateKeyFilePath()) return nil;
//    if (!privateKeyFilePassword()) privateFilePassword = @"";
    return [self decryptString:str privateKeyRef:[self getPrivateKeyRefWithContentsOfFile:RSA_privateKeyFilePath() password:RSA_privateKeyFilePassword() ? RSA_privateKeyFilePassword() : @""]];
}

/**
 * 私钥解密（使用私钥文件）
 * @param str 需要加密的str
 * @param privateKeyFilePath 私钥文件路径
 * @param privateFilePassword 私钥文件密码
 * @return 返回加密后的str
 */
+ (NSString*)RSA_decryptStr:(NSString*)str privateKeyFilePath:(NSString*)privateKeyFilePath password:(NSString*)privateFilePassword {
    if (!str || !privateKeyFilePath) return nil;
    if (!privateFilePassword) privateFilePassword = @"";
    return [self decryptString:str privateKeyRef:[self getPrivateKeyRefWithContentsOfFile:privateKeyFilePath password:privateFilePassword]];
}

#pragma mark ------- 私钥加密
+ (NSData*)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef];
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
    // This will be base64 encoded, decode it.
    NSData* data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    //a tag to read/write keychain storage
    NSString* tag = @"RSAUtil_PubKey";
    NSData* d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    // Delete any old lingering key with the same tag
    NSMutableDictionary* publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (NSData*)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    unsigned long len = [d_key length];
    if (!len) return(nil);
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int idx = 0;
    if (c_key[idx++] != 0x30) return(nil);
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    idx += 15;
    if (c_key[idx++] != 0x03) return(nil);
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    if (c_key[idx++] != '\0') return(nil);
    // Now make a new NSData from this buffer
    return ([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

+ (NSData*)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    NSMutableData* ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(keyRef,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

//获取公钥
+ (SecKeyRef)getPublicKeyRefWithContentsOfFile:(NSString *)filePath{
    NSData* certData = [NSData dataWithContentsOfFile:filePath];
    if (!certData) {
        return nil;
    }
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (CFDataRef)certData);
    SecKeyRef key = NULL;
    SecTrustRef trust = NULL;
    SecPolicyRef policy = NULL;
    if (cert != NULL) {
        policy = SecPolicyCreateBasicX509();
        if (policy) {
            if (SecTrustCreateWithCertificates((CFTypeRef)cert, policy, &trust) == noErr) {
                SecTrustResultType result;
                if (SecTrustEvaluate(trust, &result) == noErr) {
                    key = SecTrustCopyPublicKey(trust);
                }
            }
        }
    }
    if (policy) CFRelease(policy);
    if (trust) CFRelease(trust);
    if (cert) CFRelease(cert);
    return key;
}

+ (NSString*)encryptStr:(NSString *)str publicKeyRef:(SecKeyRef)publicKeyRef{
    if(![str dataUsingEncoding:NSUTF8StringEncoding]){
        return nil;
    }
    if(!publicKeyRef){
        return nil;
    }
    NSData* data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] withKeyRef:publicKeyRef];
//    NSString* ret = base64_encode_data(data);
    return base64_encode_data(data);
}

#pragma mark ------- 私钥解密
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
    // This will be base64 encoded, decode it.
    NSData* data = base64_decode(key);
    data = [self stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    //a tag to read/write keychain storage
    NSString* tag = @"RSAUtil_PrivKey";
    NSData* d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    // Delete any old lingering key with the same tag
    NSMutableDictionary* privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (NSData*)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    unsigned long len = [d_key length];
    if (!len) return(nil);
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int idx = 22; //magic byte at offset 22
    if (0x04 != c_key[idx++]) return nil;
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (NSData*)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    NSMutableData* ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

//获取私钥
+ (SecKeyRef)getPrivateKeyRefWithContentsOfFile:(NSString *)filePath password:(NSString*)password{
    NSData* p12Data = [NSData dataWithContentsOfFile:filePath];
    if (!p12Data) {
        return nil;
    }
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    return privateKeyRef;
}

+ (NSString*)decryptString:(NSString *)str privateKeyRef:(SecKeyRef)privKeyRef{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (!privKeyRef) {
        return nil;
    }
    data = [self decryptData:data withKeyRef:privKeyRef];
//    NSString* ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
