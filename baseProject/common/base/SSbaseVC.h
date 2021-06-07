//
//  SSbaseVC.h
//  baseProject
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSnaviAndStatusBarV.h"
#import "SSTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSbaseVC : UIViewController
///填充顶部状态栏view
@property(nonatomic,strong) UIView* statusBarView;
///自定义状态栏及导航栏View
@property(nonatomic,strong) SSnaviAndStatusBarV* statusAndNaviView;
///自定义强大的tableView，实现低耦合、高聚合（自动动态的给对应的cell做模型数据赋值，模型数据参数命名必须包含”model“字符串）
@property(nonatomic,strong) SSTableView* stableV;
///不建议使用这种，废弃使用
@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger pageSize;

@property(nonatomic,strong) NSString* uid;
///使用此block就拦截系统返回事件
@property(nonatomic,copy) void(^backBlock)(SSbaseVC *selfVc);

//@property(nonatomic,copy) void(^doneBlock)(void);//需要用到的时候在自控制器里使用

///导航返回箭头的图标
- (void)ss_setBackBarButtonItem:(NSString*)imgStr;
///让子类可以重写此方法
- (void)ss_backBtn;
///是否显示导航下划线 默认不显示； YED:显示； NO：不显示
- (void)ss_isShowNavigationLine:(BOOL)isShow;
///初始化并使用自定义导航栏
- (void)ss_initUseCustomNavi:(SSnaviType)naviType;
///初始化并使用自定义SSTableView 默认UITableViewStylePlain样式
- (void)ss_initUseSSTableView;
///初始化并使用自定义SSTableView
- (void)ss_initUseSSTableView:(UITableViewStyle)tableViewStyle;

@end

NS_ASSUME_NONNULL_END
