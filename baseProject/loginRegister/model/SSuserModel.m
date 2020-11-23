//
//  SSuserModel.m
//  ddz
//
//  Created by F S on 2017/7/12.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSuserModel.h"
#import <MJExtension.h>
#import <objc/runtime.h>


#define UserInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"userInfo.data"]

@implementation SSuserModel

///方式一：利用MJextension
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idStr": @"id"};
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar* ivar = class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar iva = ivar[i];
            const char* name = ivar_getName(iva);
            NSString* strName = [NSString stringWithUTF8String:name];
            //进行归档取值
            id value = [coder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count = 0;
    Ivar* ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iva = ivar[i];
        const char* name = ivar_getName(iva);
        NSString* nameStr = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:nameStr];
        //进行归档赋值
        [coder encodeObject:value forKey:nameStr];
    }
    free(ivar);
}

+ (id)shareModel {
    static SSuserModel* user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[NSFileManager defaultManager] fileExistsAtPath:UserInfoFile]) {
            user = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoFile];
        }else {
            user = [[SSuserModel alloc] init];
        }
    });
    return user;
}

- (void)saveInfo {
    do {
        [NSKeyedArchiver archiveRootObject:self toFile:UserInfoFile];
    } while (![[NSFileManager defaultManager] fileExistsAtPath:UserInfoFile]);
}

- (void)deleteInfo {
    NSError* error = nil;
    do {
        [[NSFileManager defaultManager] removeItemAtPath:UserInfoFile error:&error];
    } while ([[NSFileManager defaultManager] fileExistsAtPath:UserInfoFile]);
}

+ (void)isLOginBLock:(void (^) (BOOL isLogin))loginBLock {
    if ([SShelper isObjNil:[[NSUserDefaults standardUserDefaults] stringForKey:token]]) {
        loginBLock(NO);
    }else {
        [[SShttprequest shareRequest] httpRequest:@{} urlString:[ServerHost stringByAppendingString:@"/api/wallet"] method:HttpRequestMethodGet showLoading:NO showFailure:YES resultHandler:^(BOOL isOK, id  _Nonnull responseOnject) {
            if (isOK) {
                loginBLock(YES);
            }else {
                loginBLock(NO);
            }
        }];
    }
}

@end

