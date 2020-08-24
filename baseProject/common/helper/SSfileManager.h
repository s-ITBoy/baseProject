//
//  SSfileManager.h
//  baseProject
//
//  Created by F S on 2017/5/15.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///本地数据,文件管理类
@interface SSfileManager : NSObject

+ (instancetype)shareManager;

///删除登录用户信息
- (void)deleteUserInfo;

///删除本地数据
- (void)deleteInfo;

///清空缓存
- (void)deleteAllCache;

@end

NS_ASSUME_NONNULL_END
