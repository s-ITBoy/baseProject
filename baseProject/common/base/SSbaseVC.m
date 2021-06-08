//
//  SSbaseVC.m
//  baseProject
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSbaseVC.h"
#import "SSTableView.h"

@interface SSbaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation SSbaseVC
#pragma mark -------------- 懒加载 ------------
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight + NaviBarHeight, ScreenWidth, ScreenHeight - statusBarHeight - NaviBarHeight - TabBarHeight) style:(UITableViewStylePlain)];
        ///ios11以后 解决上拉加载后屏幕自动滚动偏移问题 需加上下面三行代码
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//FIXME: -------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self Class = %@",[self class]);
    if (IS_IOS_VERSION > 7.0) {
        ///解决被导航栏遮盖的问题,需要添加下面这行代码
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.ss_isHiddenStatusBar = NO;
    self.page = 1;
    self.pageSize = 10;
    [self ss_setBackBarButtonItem:@"navi_back"];
    [self ss_isShowNavigationLine:NO];
}

#pragma mark ---------UIGestureRecognizerDelegate  作用：拦截手势触发 -------
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark --------- 方法 -------------
- (void)setSs_isHiddenStatusBar:(BOOL)ss_isHiddenStatusBar {
    _ss_isHiddenStatusBar = ss_isHiddenStatusBar;
    [UIApplication sharedApplication].statusBarHidden = ss_isHiddenStatusBar;
}

- (void)ss_isShowNavigationLine:(BOOL)isShow {
    if (isShow) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor whiteColor]]];
    }
}

- (void)ss_setBackBarButtonItem:(NSString*)imgStr {
    UIButton* backBtn = [UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ss_backBtn) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame =CGRectMake(0, 0, 65, 44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -27, 0, 27);
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    back.title = @"";
    self.navigationItem.leftBarButtonItem = back;
}

- (void)ss_backBtn {
    if (_backBlock) {       //有block执行block返回事件
        _backBlock(self);
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

///使用自定义导航栏
- (void)ss_initUseCustomNavi:(SSnaviType)naviType {
    if (self.navigationController.navigationBar.hidden == NO) {
        self.navigationController.navigationBar.hidden = YES;
    }
    self.ss_statusAndNaviView = [[SSnaviAndStatusBarV alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIHEIGHT)];
    self.ss_statusAndNaviView.type = naviType;
    [self.view addSubview:self.ss_statusAndNaviView];
}

///使用自定义SSTableView
- (void)ss_initUseSSTableView {
    [self ss_initUseSSTableView:UITableViewStylePlain];
}

- (void)ss_initUseSSTableView:(UITableViewStyle)tableViewStyle {
    self.ss_stableV = [[SSTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIHEIGHT-TabBarHeight) style:tableViewStyle];
    if (@available(iOS 11.0, *)) {
        self.ss_stableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.ss_stableV];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, ScreenWidth, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
