//
//  SSfileManager.h
//  baseProject
//
//  Created by F S on 2017/5/15.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///本地数据、文件管理类
@interface SSfileManager : NSObject

+ (instancetype)shareManager;

#pragma mark ------------- 路径 ---------------
///沙盒中documents路径
+ (NSString*)SSdocumentsPath;
///沙盒中library路径
+ (NSString*)SSlibraryPath;
///沙盒中caches路径
+ (NSString*)SScachesPath;
///沙盒中temp路径
+ (NSString*)SStempPath;

#pragma mark ----------- 创建缓存文件夹/文件 -----------
///在caches路径下创建文件夹
+ (void)SScreateDirectoryInCachesWithPath:(NSString*)directoryPath;
///在caches路径下创建文件
+ (void)SScreateFileInCachesWithPath:(NSString*)filePath;
///在document路径下创建文件夹
+ (void)SScreateDirectoryInDocumentWithPath:(NSString*)directoryPath;
///在document路径下创建文件
+ (void)SScreateFileInDocumentWithPath:(NSString*)filePath;

#pragma mark ----------- 写入数据到文件中 -------------
///将文本数据写入文件中
+ (void)SSwriteStrToFile:(NSString*)textStr filePath:(NSString*)filePath;
///将数组数据写入文件中
+ (void)SSwriteArrToFile:(NSArray*)arr filePath:(NSString*)filePath;
///将字典数据写入文件中
+ (void)SSwirteDicToFile:(NSDictionary*)dic filePath:(NSString*)filePath;
///将自定义数据写入文件
+ (void)SSwriteCustomToFile:(id)idData filePath:(NSString*)filePath;

#pragma mark ----------- 清楚缓存信息 --------------
///删除登录用户信息
+ (void)SSclearNSuserDefault;
///清空documents路径下的文件及文件夹
+ (void)SSclearDocuments;
///清空cache文件夹下的文件及文件夹
+ (void)SSclearCache;

#pragma mark --------- 计算文件大小 -------------
///documents路径下内容的大小
+ (unsigned long long)SSfileSizeForDocument;
///cacahes路径下内容的大小
+ (unsigned long long)SSfileSizeForCaches;
///将计算好的大小以 KB/MB/GB 形式展示
+ (NSString*)SSsizeStr:(unsigned long long)size;

@end

NS_ASSUME_NONNULL_END
