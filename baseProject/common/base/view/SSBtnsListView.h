//
//  SSBtnsListView.h
//  ddz
//
//  Created by FL S on 2019/12/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedBtnViewBLock)(NSInteger index);

///单行多个按钮view
@interface SSBtnsListView : UIView
@property(nonatomic,strong) NSArray* titleArray;
///制定当前点中第几个
@property(nonatomic,assign) NSInteger selectedINdex;
///默认颜色为darkGrayColor
@property(nonatomic,strong) UIColor* titleColor;
///默认颜色为blackColor
@property(nonatomic,strong) UIColor* titleSelectedColor;
///默认为14号字体
@property(nonatomic,strong) UIFont* titleFont;

///跟踪按钮滑动的线条的颜色
@property(nonatomic,strong) UIColor* sliderColor;
///默认为2
@property(nonatomic,assign) CGFloat sliderWidth;
///默认为15
@property(nonatomic,assign) CGFloat sliderHeigth;
///到父视图底部的距离
@property(nonatomic,assign) CGFloat sliderToBottom;
///底部分割线的颜色，默认透明色
@property(nonatomic,strong) UIColor* separatoeColor;

@property(nonatomic,copy) SelectedBtnViewBLock selectedBlock;
@end

NS_ASSUME_NONNULL_END
