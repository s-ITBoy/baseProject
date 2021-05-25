//
//  SSlanguageManager.m
//  baseProject
//
//  Created by FL S on 2021/5/25.
//  Copyright © 2021 FL S. All rights reserved.
//

#import "SSlanguageManager.h"
#import <objc/runtime.h>

@interface SSBundle : NSBundle

@end
@implementation SSBundle

static const char ssbundle = 0;

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &ssbundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [SSBundle class]);
    });
    
    objc_setAssociatedObject([NSBundle mainBundle], &ssbundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation SSlanguageManager

/*
 挡在app内设置切换语言时，需在didFinishLaunchingWithOptions方法中添加如下代码：
 if ([[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"] isEqualToString:@""]) {
     [NSBundle setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]];
 }
 */
+ (void)SSsetLanguage:(NSString*)language {
    [NSBundle setLanguage:language];
}

@end
