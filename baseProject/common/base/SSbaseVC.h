//
//  SSbaseVC.h
//  baseProject
//
//  Created by F S on 2019/12/11.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YQLoadingView.h"
///头部
typedef void(^HeaderRefreshBlock)(void);
///底部
typedef void(^FooterRefreshBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface SSbaseVC : UIViewController
///填充顶部状态栏view
@property(nonatomic,strong) UIView* statusBarView;
@property(nonatomic,strong) UITableView* tableView;

//@property(nonatomic,strong) YQLoadingView* loadingView;

@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger pageSize;

@property(nonatomic,strong) NSString* uid;
///使用此block就拦截系统返回事件
@property(nonatomic,copy) void(^backBlock)(SSbaseVC *selfVc);

//@property(nonatomic,copy) void(^doneBlock)(void);//需要用到的时候在自控制器里使用

///头部下拉刷新
@property(nonatomic,copy) HeaderRefreshBlock headerBlock;
///底部上拉加载
@property(nonatomic,copy) FooterRefreshBlock footerBlock;
///导航返回箭头的颜色
- (void)setBackBarButtonItem:(UIColor*)color;

- (void)backBtn; //让子类可以重写此方法
///是否显示n导航下划线 YED:显示； NO：不显示
- (void)isShowNavigationLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
