//
//  SScaculatorMaker.m
//  baseProject
//
//  Created by FL S on 2020/11/11.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SScaculatorMaker.h"

@implementation SScaculatorMaker

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (SScaculatorMaker * _Nonnull (^)(int))add {
    return ^SScaculatorMaker*(int value) {
        NSLog(@"--------- value = %d",value);
        self->_result += value;
        return self;
    };
}

- (void)asdf {
    
}

@end

@implementation NSObject (SScaculator)

+ (int)makeCaculators:(void (^)(SScaculatorMaker * _Nonnull))caculators {
    SScaculatorMaker* mgr = [[SScaculatorMaker alloc] init];
    caculators(mgr);
    return mgr.result;
}

@end
