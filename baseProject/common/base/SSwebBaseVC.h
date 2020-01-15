//
//  SSwebBaseVC.h
//  leeMail
//
//  Created by F S on 2019/7/16.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
NS_ASSUME_NONNULL_BEGIN

@protocol SSjsObjectDelegate <JSExport>
- (void)toCopy:(NSString *)message;

@end

@interface SSjsObject : NSObject<SSjsObjectDelegate>
@property(nonatomic,weak) id<SSjsObjectDelegate> delegate;
@end

@interface SSwebBaseVC : SSbaseVC
@property(nonatomic,strong) NSString* urlString;
@end

NS_ASSUME_NONNULL_END
