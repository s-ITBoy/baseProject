//
//  SSfileManager.m
//  baseProject
//
//  Created by F S on 2020/5/15.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSfileManager.h"
//#import "SSuserModel.h"

@implementation SSfileManager

static SSfileManager* fileManager = nil;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[SSfileManager alloc] init];
    });
    return fileManager;
}

///删除登录用户信息
- (void)deleteUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//    [[SSuserModel shareModel] deleteInfo];
}

///删除本地数据
- (void)deleteInfo {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:""];
}

///清空缓存
- (void)deleteAllCache {
    
}


@end
