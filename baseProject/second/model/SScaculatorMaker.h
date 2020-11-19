//
//  SScaculatorMaker.h
//  baseProject
//
//  Created by FL S on 2020/11/11.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SScaculatorMaker;

NS_ASSUME_NONNULL_BEGIN

typedef SScaculatorMaker*_Nullable(^qwer)(void);
@interface SScaculatorMaker : NSObject

@property(nonatomic,copy) void (^SSreturnBLock) (void);
@property(nonatomic,copy) qwer qw;
//- (void)adds:(void(^)(void))block;

@property(nonatomic,assign) int result;
@property(nonatomic,assign) BOOL isEqule;

- (SScaculatorMaker*(^)(int))add;
- (SScaculatorMaker*(^)(void))plus;

- (SScaculatorMaker*)caculator:(int(^)(int result))caculator;

- (SScaculatorMaker*)equle:(BOOL(^)(int result))operation;


@end

@interface NSObject (SScaculator)
+ (int)makeCaculators:(void(^)(SScaculatorMaker* maker))caculators;
@end

NS_ASSUME_NONNULL_END
