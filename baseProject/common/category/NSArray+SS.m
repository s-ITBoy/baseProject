//
//  NSArray+SS.m
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "NSArray+SS.h"

@implementation NSArray (SS)

- (id)SSarrayAtIndex:(NSInteger)index {
    if (self.count <= 0) {
        return @[];
    }
    if (index >= self.count) {
        return @[];
    }
    id object = [self objectAtIndex:index];
    if (![object isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return [self objectAtIndex:index];
}

- (id)SSdicAtIndex:(NSInteger)index {
    if (self.count <= 0) {
        return @{};
    }
    if (index >= self.count) {
        return @{};
    }
    id object = [self objectAtIndex:index];
    if (![object isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return [self objectAtIndex:index];
}

- (id)SSstringAtIndex:(NSInteger)index {
    if (self.count <= 0) {
        return @"";
    }
    if (index >= self.count) {
        return @"";
    }
    id object = [self objectAtIndex:index];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    if (![object isKindOfClass:[NSString class]]) {
        return @"";
    }
    return [self objectAtIndex:index];
}

- (id)SSobjectAtArrayIndex:(NSUInteger)index {
    if (!self.count) {
        return @"";
    }
    if (index >= self.count) {
        return @"";
    }
    return [self objectAtIndex:index];
}

///将数组元素序列化成NSData
- (NSData *)SStransferToData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

///数组转JSON字符串
- (NSString*)SSarrayToJSONString {
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
    if (data == nil) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
