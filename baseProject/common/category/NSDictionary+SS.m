//
//  NSDictionary+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "NSDictionary+SS.h"

@implementation NSDictionary (SS)

- (NSArray*)SSarrayForDicKey:(NSString*)key {
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return @[];
    }
    if (!self) {
        return @[];
    }
    if (!key) {
        return @[];
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return @[];
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return @[];
    }
    return obj;
}

- (NSDictionary*)SSdicForDicKey:(NSString*)key {
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return @{};
    }
    if (!self) {
        return @{};
    }
    if (!key) {
        return @{};
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return @{};
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return @{};
    }
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return obj;
}

- (NSString*)SSstringForDicKey:(NSString*)key {
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return @"";
    }
    if (!self) {
        return @"";
    }
    if (!key) {
        return @"";
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return @"";
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj stringValue];
    }
    return obj;
}

- (BOOL)SSboolForDicKey:(NSString*)key {
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return NO;
    }
    if (!self) {
        return NO;
    }
    if (!key) {
        return NO;
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return NO;
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@"true"] || [obj isEqualToString:@"TRUE"]) {
            return YES;
        }else {
            return NO;
        }
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            return obj;
        }else {
            return [obj boolValue];
        }
    }
    return NO;
}

- (id)SSobjectForDictKey:(id)key {
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return @"";
    }
    if (!self) {
        return @"";
    }
    if (!key) {
        return @"";
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return @"";
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return obj;
}

- (NSString *)SSdictionryToJSONString {
    NSError *parseError;
    NSData *parseData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (!parseData || parseError) {
        return @"";
    }
    NSString *jsonString = [[NSString alloc] initWithData:parseData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSData *)SStransferToData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

- (NSDictionary *)SSdeleteEmptyValue{
    NSMutableDictionary *dict = self.mutableCopy;
    NSArray *keys = [dict allKeys];
    ///方式一
//    for (NSString *key in keys) {
//        id value = [dict objectForKey:key];
//        if ([self isObjNil:value]) {
//            [dict removeObjectForKey:key];
//        }
//    }
    ///方式二
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [dict objectForKey:obj];
        if ([self isObjNil:value]) {
            [dict removeObjectForKey:obj];
        }
    }];
    return dict;
}

- (BOOL)isObjNil:(id _Nullable )obj{
    if (!obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)obj;
        if (dictionary.allKeys.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        if (array.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if (![obj length] || obj == nil || obj == NULL || [obj isKindOfClass:[NSNull class]] || [[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [obj isEqualToString:@"(null)"] || [obj isEqualToString:@"    "]) {
            return YES;
        }
    }
    return NO;
}

@end
