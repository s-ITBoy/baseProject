//
//  SSfileManager.m
//  baseProject
//
//  Created by F S on 2017/5/15.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSfileManager.h"

@implementation SSfileManager

static SSfileManager* fileManager = nil;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[SSfileManager alloc] init];
    });
    return fileManager;
}

#pragma mark ------------- 路径 ---------------
///沙盒中documents路径
+ (NSString*)SSdocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中library路径
+ (NSString*)SSlibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中caches路径
+ (NSString*)SScachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中temp路径
+ (NSString*)SStempPath {
    return NSTemporaryDirectory();
}

#pragma mark ----------- 创建缓存文件夹/文件 -----------
///在caches路径下创建文件夹
+ (void)SScreateDirectoryWithCachesPath:(NSString*)directoryPath {
    [[NSFileManager defaultManager] createDirectoryAtPath:[[self SScachesPath] stringByAppendingPathComponent:directoryPath] withIntermediateDirectories:YES attributes:nil error:nil];
}

///在caches路径下创建文件
+ (void)SScreateFileWithCachesPath:(NSString*)filePath {
    [[NSFileManager defaultManager] createFileAtPath:[[self SScachesPath] stringByAppendingPathComponent:filePath] contents:nil attributes:nil];
}

///在document路径下创建文件夹
+ (void)SScreateDirectoryWithDocumentPath:(NSString*)directoryPath {
    [[NSFileManager defaultManager] createDirectoryAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:directoryPath] withIntermediateDirectories:YES attributes:nil error:nil];
}

///在document路径下创建文件
+ (void)SScreateFileWithDocumentPath:(NSString*)filePath {
    [[NSFileManager defaultManager] createFileAtPath:[[self SScachesPath] stringByAppendingPathComponent:filePath] contents:nil attributes:nil];
}

#pragma mark ----------- 写入数据到文件中 -------------
///将文本数据写入文件中
+ (void)SSwriteStrToFile:(NSString*)textStr filePath:(NSString*)filePath {
    if (!textStr) {
        return;
    }
    if (!filePath) {
        return;
    }
    BOOL isSuccess = [textStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }
    //方式二：
    while (isSuccess == NO) {
        isSuccess = [textStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}
///将数组数据写入文件中
+ (void)SSwriteArrToFile:(NSArray*)arr filePath:(NSString*)filePath {
    if (arr.count <= 0) {
        return;
    }
    if (!filePath) {
        return;
    }
    BOOL isSuccess = [arr writeToFile:filePath atomically:YES];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }
    //方式二：
    while (isSuccess == NO) {
        isSuccess = [arr writeToFile:filePath atomically:YES];
    }
    
}
///将字典数据写入文件中
+ (void)SSwirteDicToFile:(NSDictionary*)dic filePath:(NSString*)filePath {
    if (dic.allKeys.count <= 0) {
        return;
    }
    if (!filePath) {
        return;
    }
    BOOL isSuccess = [dic writeToFile:filePath atomically:YES];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }
    //方式二：
    while (isSuccess == NO) {
        isSuccess = [dic writeToFile:filePath atomically:YES];
    }
}

#pragma mark ----------- 清楚缓存信息 --------------
///删除登录用户信息
+ (void)SSclearNSuserDefault {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
}

///清空documents路径下的文件及文件夹
+ (void)SSclearDocuments {
    //一
    NSArray* filePaths = [[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]];
    for (NSString* fileP in filePaths) {
        NSError* error;
        [[NSFileManager defaultManager] removeItemAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP] error:&error];
    }
    //二
//    NSArray* filePaths = [[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]];
//    for (NSString* fileP in filePaths) {
//        NSError* error;
//        do {
//            [[NSFileManager defaultManager] removeItemAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP] error:&error];
//        } while ([[NSFileManager defaultManager] fileExistsAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP]]);
//    }
}

///清空cache文件夹下的文件及文件夹
+ (void)SSclearCache {
    //一
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]]) {
        NSError* error;
        [[NSFileManager defaultManager] removeItemAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP] error:&error];
    }
    //二
//    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]]) {
//        NSError* error;
//        do {
//            [[NSFileManager defaultManager] removeItemAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP] error:&error];
//        } while ([[NSFileManager defaultManager] fileExistsAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP]]);
//    }
}

#pragma mark --------- 计算文件大小 -------------

+ (unsigned long long)SSfileSizeForDocument {
    unsigned long long size = 0;
    if ([[[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]] count] <= 0) {
        return size;
    }
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]]) {
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP] error:nil] fileSize];
    }
    return size;
}

+ (unsigned long long)SSfileSizeForCaches {
    unsigned long long size = 0;
    if ([[[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]] count] <= 0) {
        return size;
    }
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]]) {
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP] error:nil] fileSize];
    }
    return size;
}

///将计算好的大小以 KB/MB/GB 形式展示
+ (NSString*)SSsizeStr:(unsigned long long)size {
    if (size < 1024) {
        return [NSString stringWithFormat:@"%lluB",size];
    }else if (size < 1024*1024) {
        return [NSString stringWithFormat:@"%.2fKB",(float)size/1024];
    }else if (size < 1024*1024*1024) {
        return [NSString stringWithFormat:@"%.2fMB", (float)size/(1024*1024)];
    }else {
        return [NSString stringWithFormat:@"%.2fMB",(float)size/(1024*1024*1024)];
    }
}


@end
