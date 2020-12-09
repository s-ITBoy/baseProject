//
//  SSleftTextInputV.h
//  baseProject
//
//  Created by F S on 2017/1/2.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSleftTextInputV : UIView
@property(nonatomic,strong,readonly) UITextField* textFD;
///默认键盘类型为系统默认的
@property(nonatomic,assign) UIKeyboardType keyBoardType;
@property(nonatomic,strong) NSString* leftStr;
@property(nonatomic,strong) NSString* placeHoderStr;
///左侧text的lab的宽度 默认60(用于显示四个字)
@property(nonatomic,assign) CGFloat leftWidth;
@end

NS_ASSUME_NONNULL_END
