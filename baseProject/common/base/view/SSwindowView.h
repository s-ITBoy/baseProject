//
//  SSwindowView.h
//  leeMail
//
//  Created by F S on 2019/8/2.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///弹框视图基类
@interface SSwindowView : UIView
@property (strong,nonatomic,readonly) UIView* backgroundView;
@property (weak,nonatomic) UIView* contentView;
@property (assign,nonatomic) BOOL anim;
@property (assign,nonatomic) BOOL isShow;
@property (assign,nonatomic) UIViewContentMode contentMode;
-(instancetype) customViewWithAlpha:(CGFloat) alp;
-(instancetype) customerView;
-(void) show;
-(void) dismiss;

///contentView:需要展示的弹框图
+(SSwindowView*) showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode;
+(BOOL) isShowCustomView;
+(void) dismissCustomView;
@end

NS_ASSUME_NONNULL_END
