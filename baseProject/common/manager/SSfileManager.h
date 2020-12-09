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
- (void)SSclearNSuserDefault;

///清空documents路径下的文件及文件夹
- (void)SSclearDocuments;

///清空cache文件夹下的文件及文件夹
- (void)SSclearCache;

///documents路径下内容的大小
- (unsigned long long)SSfileSizeForDocument;
///cacahes路径下内容的大小
- (unsigned long long)SSfileSizeForCaches;

///将计算好的大小以 KB/MB/GB 形式展示
- (NSString*)SSsizeStr:(unsigned long long)size;

@end

NS_ASSUME_NONNULL_END
