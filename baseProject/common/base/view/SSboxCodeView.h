//
//  SSboxCodeView.h
//  baseProject
//
//  Created by F S on 2020/4/24.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

// 输入密码的位数
static const int boxCount = 4;
// 输入方格的边长宽
static const CGFloat boxW = 56;
// 输入方格的边长高
static const CGFloat boxH = 74;
// 方格间的间距
static const CGFloat margin = 19.5;

NS_ASSUME_NONNULL_BEGIN
///方格形式的验证码输入view
@interface SSboxCodeView : UIView

@property(nonatomic,copy) void (^SSReturnPasswordStrBLock) (NSString* textStr);
///弹出键盘
- (void)becomeFirstReponse;
- (void)changeText:(NSString*)text;
- (void)clearText;
@end

NS_ASSUME_NONNULL_END
