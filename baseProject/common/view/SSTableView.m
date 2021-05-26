//
//  SSTableView.m
//  baseProject
//
//  Created by apple on 2019/5/26.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "SSTableView.h"
#import <objc/runtime.h>

@interface NSObject (SSTableV)
@property (nonatomic, strong) NSNumber *cellHight;
@end
@implementation NSObject (SSTableV)

- (void)setCellHight:(NSNumber *)cellHight {
    objc_setAssociatedObject(self, @"cellHight",cellHight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)cellHight {
    return objc_getAssociatedObject(self, @"cellHight");
}


-(id)ss_safeValueForKey:(NSString *)key {
    if ([self hasKey:key]) {
        return [self valueForKey:key];
    }
    return nil;
}

-(void)ss_safeSetValue:(id)value forKey:(NSString *)key {
    if([self hasKey:key]) {
        [self setValue:value forKey:key];
    }
}

-(BOOL)hasKey:(NSString *)key {
    return [self respondsToSelector:NSSelectorFromString(key)];
}

@end

@interface SSTableView ()

@end
@implementation SSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
