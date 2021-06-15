//
//  SSlanguageManager.h
//  baseProject
//
//  Created by FL S on 2018/5/25.
//  Copyright © 2018 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///语言管理类
@interface SSlanguageManager : NSObject
///app内设置切换语言
+ (void)SSsetLanguage:(NSString*)language;

@end

NS_ASSUME_NONNULL_END
