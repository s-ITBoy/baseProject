//
//  NSArray+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SS)

- (NSArray*)SSarrayAtIndex:(NSInteger)index;

- (NSDictionary*)SSdicAtIndex:(NSInteger)index;

- (NSString*)SSstringAtIndex:(NSInteger)index;

- (id)SSobjectAtArrayIndex:(NSUInteger)index;

///将数组元素序列化成NSData
- (NSData*)SSarrayToData;
///数组转JSON字符串
- (NSString*)SSarrayToJSONString;
///数组转字符串; seperatorStr:表示分割符
- (NSString*)SSarraytoStr:separatorStr;

///冒泡排序
- (NSArray*)SSbubbleSortArr;
///选择排序
- (NSArray*)SSselectSortArr;
///快速排序
- (NSArray*)SSquickSortArr;


@end

NS_ASSUME_NONNULL_END
