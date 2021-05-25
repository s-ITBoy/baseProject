//
//  SSbaseVC.m
//  baseProject
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSbaseVC.h"

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
- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, statusBarHeight)];
        _statusBarView.backgroundColor = [UIColor whiteColor];
    }
    return _statusBarView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if(self.navigationController.childViewControllers.count == 1){
        return NO;
    }
    return YES;
    
}
//FIXME: -------
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self Class = %@",[self class]);
    if (IS_IOS_VERSION > 7.0) {
        ///解决被导航栏遮盖的问题,需要添加下面这行代码
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    self.page = 1;
    self.pageSize = 10;
    [self setBackBarButtonItem:[UIColor lightGrayColor]];
    
    [self isShowNavigationLine:NO];
}

- (void)isShowNavigationLine:(BOOL)isShow {
    if (isShow) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor whiteColor]]];
    }
}

- (void)setBackBarButtonItem:(UIColor*)color {
    //    if (IS_IOS_10) {
    UIButton* backBtn = [UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    //        backBtn.frame = CGRectMake(0, 0, 11, 21);
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    backBtn.frame =CGRectMake(0, 0, 65, 32);
    //    backBtn.backgroundColor = [UIColor YQredColor];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -27, 0, 27);
//    [backBtn YQsetEnlargeEdgeWithTop:1 right:10 bottom:1 left:10];
    //        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    back.title = @"";
    //        back.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = back;
    //    }else{
    //        UIBarButtonItem* back = [[UIBarButtonItem alloc] init];
    //        back.title = @"";
    //        back.tintColor = color;
    //
    //        self.navigationItem.backBarButtonItem = back;
    //    }
}

- (void)backBtn {
    if (_backBlock) {       //有block执行block返回事件
        _backBlock(self);
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
