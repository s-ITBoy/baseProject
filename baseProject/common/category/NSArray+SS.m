//
//  NSArray+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "NSArray+SS.h"

@implementation NSArray (SS)

- (NSArray*)SSarrayAtIndex:(NSInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return @[];
    }
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

- (NSDictionary*)SSdicAtIndex:(NSInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return @{};
    }
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

- (NSString*)SSstringAtIndex:(NSInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return @"";
    }
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
    if (self.count <= 0) {
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

///数组转字符串
- (NSString*)SSarraytoStr:separatorStr {
    return [self componentsJoinedByString:separatorStr];
}

///子视图数组中的所有子视图移除动画效果
- (void)SSremoveAllAnimation {
    for (UIView* view in self) {
        [view.layer removeAllAnimations];
    }
}

///冒泡排序
- (NSArray*)SSbubbleSortArr {
    NSMutableArray* arr = [self mutableCopy];
//    id tmp;
    for (int i=0; i<arr.count; i++) {
        for (int j=0; j<arr.count-i-1; j++) {
            if (arr[j] > arr[j+1]) {
//                tmp = arr[j];
//                arr[j] = arr[j+1];
//                arr[j+1] = tmp;
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return arr;
}
///选择排序
- (NSArray*)SSselectSortArr {
    NSMutableArray* arr = [self mutableCopy];
    for (int i = 0; i < arr.count-1;i++) {
        int pos = i;
        for(int j = i +1; j < arr.count;j++){
            if(arr[pos] > arr[j]){
                pos = j;
            }
        }
        id tmp = arr[i];
        arr[i] = arr[pos];
        arr[pos] = tmp;
    }
    return arr;
}

///快速排序
- (NSArray*)SSquickSortArr {
    
    
    return @[];
}

@end
