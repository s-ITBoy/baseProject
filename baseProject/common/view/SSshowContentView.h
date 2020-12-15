//
//  SSshowContentView.h
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///提示消息文字view
@interface SSshowContentView : UIView

/*
 * Tip：tip的text
 */
@property (nonatomic,retain,readwrite)NSString* msg;
/*
 * Tip：view的背景色
 */
@property (nonatomic,retain,readwrite)UIColor* backGroundColor;
/*
 * Tip：tip的字体颜色
 */
@property (nonatomic,retain,readwrite)UIColor* msgColor;
/*
 * 渐变时间
 */
@property (nonatomic,retain,readwrite)UIFont* font;
/*
 * Tip：显示多长时间后隐藏
 */
@property (nonatomic,assign,readwrite)CGFloat duration;
/*
 * Tip：显示多长时间后隐藏
 */
@property (nonatomic,assign,readwrite)CGFloat delay;

/*
 * 视图显示的y坐标
 */
@property (nonatomic,assign,readwrite)CGFloat y;

/*
 * Tip：显示view
 */
- (void)show;

- (void)SSshowMsg:(NSString*_Nullable)msg;


@end

NS_ASSUME_NONNULL_END
