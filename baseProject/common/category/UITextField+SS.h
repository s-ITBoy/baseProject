//
//  UITextField+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SS)

///创建UITextField
+ (UITextField*)SStextField:(NSString*)placeHolder andTextColor:(UIColor*)textColor andFont:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
