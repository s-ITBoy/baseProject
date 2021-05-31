//
//  UIViewController+SS.m
//  baseProject
//
//  Created by F S on 2017/7/10.
//  Copyright © 2017 F S. All rights reserved.
//

#import "UIViewController+SS.h"

@implementation UIViewController (SS)

#pragma mark --------- 跳转VC ----------
//push
- (void)SS_pushVCWithClassStr:(NSString*_Nullable)classStr withPropertyDic:(NSDictionary*_Nullable)propertyDic {
    if (!classStr) {
        return;
    }
    id vc = [self getVCfromStr:classStr andProperty:propertyDic];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        [[vc valueForKeyPath:@"hidesBottomBarWhenPushed"] intValue] != 0 ? : [vc setValue:@(YES) forKeyPath:@"hidesBottomBarWhenPushed"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//present
- (void)SS_presentVCWithClassStr:(NSString*_Nullable)classStr withPropertyDic:(NSDictionary*_Nullable)propertyDic {
    if (!classStr) {
        return;
    }
    id vc = [self getVCfromStr:classStr andProperty:propertyDic];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (id)getVCfromStr:(NSString*_Nullable)classStr andProperty:(NSDictionary*_Nullable)dic {
    Class cla = NSClassFromString(classStr);
    id vc = [[cla alloc] init];
    
    //KVC
    if (dic.allKeys.count > 0) {
        //方式一：
//        for (NSString* key in dic.allKeys) {
//            [vc setValue:dic[key] forKeyPath:key];
//        }
        //方式二：
        [vc setValuesForKeysWithDictionary:dic];
    }
    
    return vc;
}

///KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
