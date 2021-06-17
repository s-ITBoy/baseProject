//
//  NSDictionary+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SS)

- (NSArray*)SSarrayForDicKey:(NSString*)key;

- (NSDictionary*)SSdicForDicKey:(NSString*)key;

- (NSString*)SSstringForDicKey:(NSString*)key;

- (BOOL)SSboolForDicKey:(NSString*)key;

- (id)SSobjectForDictKey:(id)key;

- (NSString*)SSdictionryToJSONString;

- (NSData*)SSdicToData;

- (NSDictionary*)SSdeleteEmptyValue;

@end


