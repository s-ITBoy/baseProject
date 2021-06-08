//
//  SSwebBaseVC.h
//  baseProject
//
//  Created by F S on 2017/8/27.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSbaseVC.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^decisionHandler)(WKNavigationActionPolicy);

@interface SSwebBaseVC : SSbaseVC
///URL
@property(nonatomic,strong) NSString* urlString;
///是否使用自定义导航栏；默认为NO：不适用
@property(nonatomic,assign) BOOL isUseCustomNavi;
///是否显示webView加载时的进度条progress； 默认为YES：显示
@property(nonatomic,assign) BOOL isShowProgress;
//进度条加载的颜色；默认蓝色
@property(nonatomic,strong) UIColor* progressTintColor;
///当使用自己定义导航栏时，progress的y坐标值，默认0；
@property(nonatomic,assign) CGFloat progressYY;


///加载完成 非必须
@property(nonatomic,copy) void (^ss_didfinishLoading)(WKWebView* webView, WKNavigation* navigation);
///界面跳转 非必须
@property(nonatomic,copy) void (^ss_decidePolicyForNavigationAction)(WKWebView* webView, decisionHandler handler);

@end

NS_ASSUME_NONNULL_END
