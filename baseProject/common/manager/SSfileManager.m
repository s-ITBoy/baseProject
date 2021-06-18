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

///沙盒根目录
+ (NSString*)SShomePath {
    return NSHomeDirectory();
}

+ (NSString*)positionPath:(SSfilePosition)filePosition file:(NSString*)fileName {
    switch (filePosition) {
        case SSfilePositionCaches:
            return [[self SScachesPath] stringByAppendingPathComponent:fileName];
            break;
        case SSfilePositionDocument:
            return [[self SSdocumentsPath] stringByAppendingPathComponent:fileName];
            break;
        case SSfilePositionLibrary:
            return [[self SSlibraryPath] stringByAppendingPathComponent:fileName];
            break;
        case SSfilePositionTmp:
            return [[self SStempPath] stringByAppendingPathComponent:fileName];
            break;
            
        default:
            break;
    }
    return [self SShomePath];
}

#pragma mark ----------- 创建缓存文件夹/文件 -----------
///创建文件夹
+ (void)SScreateDirectory:(NSString*)directoryName position:(SSfilePosition)filePosition {
    [[NSFileManager defaultManager] createDirectoryAtPath:[self positionPath:filePosition file:directoryName] withIntermediateDirectories:YES attributes:nil error:nil];
}

///创建文件
+ (void)SScreateFile:(NSString*)fileName position:(SSfilePosition)filePosition {
    [[NSFileManager defaultManager] createFileAtPath:[self positionPath:filePosition file:fileName] contents:nil attributes:nil];
}

#pragma mark ----------- 写入数据到文件中 -------------
///将NSdata数据写入文件中
+ (void)SSwriteData:(NSData*)data fileName:(NSString*)fileName position:(SSfilePosition)filePosition {
    if (!data) {
        return;
    }
    if (!fileName) {
        return;
    }
    BOOL isSuccess = [data writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }else {
        SSLog(@"写入失败");
    }
    //方式二：
//    while (isSuccess == NO) {
//        isSuccess = [data writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
//    }
    
}
///将文本数据写入文件中
+ (void)SSwriteStr:(NSString*)textStr fileName:(NSString*)fileName position:(SSfilePosition)filePosition {
    if (!textStr) {
        return;
    }
    if (!fileName) {
        return;
    }
    BOOL isSuccess = [textStr writeToFile:[self positionPath:filePosition file:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }else {
        SSLog(@"写入失败");
    }
    //方式二：
//    while (isSuccess == NO) {
//        isSuccess = [textStr writeToFile:[self positionPath:filePosition file:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    }
}

///将数组数据写入文件中
+ (void)SSwriteArr:(NSArray*)arr fileName:(NSString*)fileName position:(SSfilePosition)filePosition {
    if (arr.count <= 0) {
        return;
    }
    if (!fileName) {
        return;
    }
    BOOL isSuccess = [arr writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }else {
        SSLog(@"写入失败");
    }
//    //方式二：
//    while (isSuccess == NO) {
//        isSuccess = [arr writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
//    }
    
}

///将字典数据写入文件中
+ (void)SSwriteDic:(NSDictionary*)dic fileName:(NSString*)fileName position:(SSfilePosition)filePosition {
    if (dic.allKeys.count <= 0) {
        return;
    }
    if (!fileName) {
        return;
    }
    BOOL isSuccess = [dic writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
    //方式一：
    if (isSuccess) {
        SSLog(@"写入成功");
    }else {
        SSLog(@"写入失败");
    }
    //方式二：
    while (isSuccess == NO) {
        isSuccess = [dic writeToFile:[self positionPath:filePosition file:fileName] atomically:YES];
    }
}

///将自定义数据写入文件
+ (void)SSwriteCustom:(id)customModel fileName:(NSString*)fileName position:(SSfilePosition)filePosition {
    if (!customModel) {
        return;
    }
    if (!fileName) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:customModel toFile:[self positionPath:filePosition file:fileName]];
}

///用归档的方式将数据写入文件
+ (void)SSarchiver:(id)idData fileName:(NSString*)fileName position:(SSfilePosition)filePositionr {
    if (!idData) {
        return;
    }
    if (!fileName) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:idData toFile:[self positionPath:filePositionr file:fileName]];
}

#pragma mark ----------- 从文件中读取数据 -------------
///读取NSdata数据
+ (NSData*)SSgetDataFromfile:(NSString*)fileName position:(SSfilePosition)filePosition; {
    return [[NSData alloc] initWithContentsOfFile:[self positionPath:filePosition file:fileName]];
}
///读取NSString数据
+ (NSString*)SSgetStrFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition {
    return [NSString stringWithContentsOfFile:[self positionPath:filePosition file:fileName] encoding:NSUTF8StringEncoding error:nil];
}
///读取NSArray数据
+ (NSArray*)SSgetArrFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition {
    return [NSArray arrayWithContentsOfFile:[self positionPath:filePosition file:fileName]];
}
///读取NSDictionary数据
+ (NSDictionary*)SSgetDicFromeFile:(NSString*)fileName position:(SSfilePosition)filePosition; {
    return [NSDictionary dictionaryWithContentsOfFile:[self positionPath:filePosition file:fileName]];
}
///用解档的方式读取数据
+ (id)SSunarchiverFromfile:(NSString*)fileName position:(SSfilePosition)filePosition; {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self positionPath:filePosition file:fileName]];
}

#pragma mark ----------- 清楚缓存信息 --------------
///删除登录用户信息
+ (void)SSclearNSuserDefault {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
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
