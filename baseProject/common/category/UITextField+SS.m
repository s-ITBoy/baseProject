//
//  UITextField+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UITextField+SS.h"

@implementation UITextField (SS)

///创建UITextField
+ (UITextField*)SStextField:(NSString*)placeHolder andTextColor:(UIColor*)textColor andFont:(UIFont*)font {
    UITextField* textF = [[UITextField alloc] init];
    textF.placeholder = placeHolder;
    textF.textColor = textColor;
    textF.font = font;
    return textF;
}

@end
