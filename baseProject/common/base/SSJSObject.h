//
//  SSJSObject.h
//  ddz
//
//  Created by F S on 2017/12/24.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SSJSObjectDelegate <JSExport>

-(void)scan:(NSString *)message;

@end

@interface SSJSObject : NSObject

@end

NS_ASSUME_NONNULL_END
