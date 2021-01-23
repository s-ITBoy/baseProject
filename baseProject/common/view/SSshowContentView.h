//
//  SSshowContentView.h
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSloadingModel) {
    SSloadingModelActivityIndicator = 0,
    SSloadingModelActivityIndicatorAndText,
    SSloadingModelText,
    SSloadingModelCustomize
};

NS_ASSUME_NONNULL_BEGIN

///提示消息文字view
@interface SSshowContentView : UIView

/////tip的text
//@property (nonatomic,retain,readwrite)NSString* msg;
///self(view)的背景色
@property (nonatomic,retain,readwrite)UIColor* backGroundColor;
///tip的字体颜色
@property (nonatomic,retain,readwrite)UIColor* msgColor;
///字体
@property (nonatomic,retain,readwrite)UIFont* font;
///渐变时间
@property (nonatomic,assign,readwrite)CGFloat duration;
///显示多长时间后隐藏
@property (nonatomic,assign,readwrite)CGFloat delay;
///视图显示的y坐标
@property (nonatomic,assign,readwrite)CGFloat y;


#pragma mark -------- 提示语 界面点击效果不被遮挡 提示语出现时仍可点击-----------



#pragma mark -------- 提示语 界面点击效果被遮挡 提示语出现时不可点击-----------

- (void)SSshowMsg:(NSString*_Nullable)msg;

- (void)SSshowMsg:(NSString*_Nullable)msg FinishBlock:(void (^)(void))block;

- (void)SSshowMsg:(NSString*_Nullable)msg delay:(CGFloat)delay FinishBlock:(void (^)(void))block;


#pragma mark -------- 网络请求时的 加载菊花 -----------

///加载文本的内容，可不传。默认为：加载中
@property(nonatomic,strong) NSString* loadingText;
///可不传。默认为系统15号字体
@property(nonatomic,strong) UIFont* loadingTextFont;
///可不传。默认为系统黑色
@property(nonatomic,strong) UIColor* loadingTextColor;
///当model = SSloadingModelCustomize时，必须指定的参数，且customView为展示的内容
@property(nonatomic,strong) UIView* customView;

///此方法 SSloadingModel 默认为：SSloadingModelActivityIndicator
- (void)SSshowLoadingSSHUD;

///当model = SSloadingModelCustomize时，customView为必传值（即：customView不能为空）
- (void)SSshowLoadingSSHUD:(SSloadingModel)model;

- (void)SShiddenLoadingSSHUD;

- (void)SShiddenAllLoading;

@end

NS_ASSUME_NONNULL_END
