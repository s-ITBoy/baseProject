//
//  SScustomTextView.h
//  ddz
//
//  Created by F S on 2017/1/2.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//自定义textView(带有占位符文字的)
@interface SScustomTextView : UITextView
///占位文字
@property (nonatomic, copy) NSString *placeholder;
///占位文字的颜色
@property (nonatomic, strong) UIColor *placeholderColor;
@end

NS_ASSUME_NONNULL_END
