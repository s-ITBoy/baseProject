//
//  SStextLayer.h
//  ddz
//
//  Created by F S on 2019/12/23.
//  Copyright © 2019 F S. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
///数字跳动
@interface SStextLayer : CATextLayer
- (void)jumpNumberWithDuration:(int)duration fromNumber:(float)startNumber toNumber:(float)endNumber;

- (void)jumpNumber;
@end

NS_ASSUME_NONNULL_END
