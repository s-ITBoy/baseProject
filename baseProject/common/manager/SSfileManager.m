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
///沙盒中documents路径
- (NSString*)SSdocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中library路径
- (NSString*)SSlibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中caches路径
- (NSString*)SScachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

///沙盒中temp路径
- (NSString*)SStempPath {
    return NSTemporaryDirectory();
}

///删除登录用户信息
- (void)SSclearNSuserDefault {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
}

///删除本地数据
- (void)SSclearDocuments {
    NSArray* filePaths = [[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]];
    for (NSString* fileP in filePaths) {
        NSError* error;
        do {
            [[NSFileManager defaultManager] removeItemAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP] error:&error];
        } while ([[NSFileManager defaultManager] fileExistsAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP]]);
    }
}

///清空缓存
- (void)SSclearCache {
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]]) {
        NSError* error;
        do {
            [[NSFileManager defaultManager] removeItemAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP] error:&error];
        } while ([[NSFileManager defaultManager] fileExistsAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP]]);
    }
}

- (unsigned long long)SSfileSizeForDocument {
    unsigned long long size = 0;
    if ([[[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]] count] <= 0) {
        return size;
    }
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SSdocumentsPath]]) {
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:[[self SSdocumentsPath] stringByAppendingPathComponent:fileP] error:nil] fileSize];
    }
    return size;
}

- (unsigned long long)SSfileSizeForCaches {
    unsigned long long size = 0;
    if ([[[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]] count] <= 0) {
        return size;
    }
    for (NSString* fileP in [[NSFileManager defaultManager] subpathsAtPath:[self SScachesPath]]) {
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:[[self SScachesPath] stringByAppendingPathComponent:fileP] error:nil] fileSize];
    }
    return size;
}


@end
