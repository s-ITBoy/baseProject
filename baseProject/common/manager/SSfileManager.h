//
//  SSfileManager.h
//  baseProject
//
//  Created by F S on 2017/5/15.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SSfilePosition) {
    SSfilePositionCaches     = 0,
    SSfilePositionDocument,
    SSfilePositionLibrary,
    SSfilePositionTmp,
};

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
///沙盒根目录
+ (NSString*)SShomePath;

#pragma mark ----------- 创建缓存文件夹/文件 -----------
///创建文件夹
+ (void)SScreateDirectory:(NSString*)directoryName position:(SSfilePosition)filePosition;
///创建文件
+ (void)SScreateFile:(NSString*)fileName position:(SSfilePosition)filePosition;

#pragma mark ----------- 写入数据到文件中 -------------
///将NSdata数据写入文件中
+ (void)SSwriteData:(NSData*)data fileName:(NSString*)fileName position:(SSfilePosition)filePosition;
///将文本数据写入文件中
+ (void)SSwriteStr:(NSString*)textStr fileName:(NSString*)fileName position:(SSfilePosition)filePosition;
///将数组数据写入文件中
+ (void)SSwriteArr:(NSArray*)arr fileName:(NSString*)fileName position:(SSfilePosition)filePosition;
///将字典数据写入文件中
+ (void)SSwriteDic:(NSDictionary*)dic fileName:(NSString*)fileName position:(SSfilePosition)filePosition;
///将自定义数据写入文件
+ (void)SSwriteCustom:(id)customModel fileName:(NSString*)fileName position:(SSfilePosition)filePosition;
///用归档的方式将数据写入文件
+ (void)SSarchiver:(id)idData fileName:(NSString*)fileName position:(SSfilePosition)filePosition;

#pragma mark ----------- 从文件中读取数据 -------------
///读取NSdata数据
+ (NSData*)SSgetDataFromfile:(NSString*)fileName position:(SSfilePosition)filePosition;
///读取NSString数据
+ (NSString*)SSgetStrFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition;
///读取NSarray数据
+ (NSArray*)SSgetArrFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition;
///读取NSDictionary数据
+ (NSDictionary*)SSgetDicFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition;
///读取数据
+ (id)SSunarchiverFromfile:(NSString*)fileName position:(SSfilePosition)filePosition;

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
