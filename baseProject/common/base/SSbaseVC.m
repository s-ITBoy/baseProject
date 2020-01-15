//
//  SSbaseVC.m
//  baseProject
//
//  Created by F S on 2019/12/11.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "SSbaseVC.h"

@interface SSbaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation SSbaseVC
#pragma mark -------------- 懒加载 ------------
-(UITableView *)tableView{
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
        _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        [self.view addSubview:_tableView];
        
        //        //1 使用框架UI样式，直接调用
        //
        //        NSMutableArray *images = [NSMutableArray new];
        //        for (int i = 1; i <= 12; i++) {
        //            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"houziloading_0000%0.2d",i]];
        //            [images addObject:image];
        //        }
        //        self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageArray:images
        //                                                                titleStr:@"努力加载中..."
        //                                                               detailStr:@""];
        //
        
        //        UIImageView *loadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        //        loadView.animationImages = images;
        //        loadView.animationDuration = 0.04*images.count;
        //
        //        [loadView startAnimating];
        //
        //        self.tableView.ly_emptyView = [LYEmptyView emptyViewWithCustomView:loadView];
        
        //emptyView内容上的点击事件监听
        //        __weak typeof(self)weakSelf = self;
        //        [self.tableView.ly_emptyView setTapContentViewBlock:^(){
        ////            [weakSelf requestData];
        //        }];
    }
    
    return _tableView;
}
- (UIView *)statusBarView{
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, statusBarHeight)];
        _statusBarView.backgroundColor = [UIColor whiteColor];
    }
    return _statusBarView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if(self.navigationController.childViewControllers.count == 1){
        return NO;
    }
    return YES;
    
}
//FIXME: -------
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self Class = %@",[self class]);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    self.page = 1;
    self.pageSize = 10;
    [self setBackBarButtonItem:[UIColor lightGrayColor]];
    
    [self isShowNavigationLine:NO];
    // bg.png为自己ps出来的想要的背景颜色。
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbarLine.png"] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"tabbarLine.png"]];
}

- (void)isShowNavigationLine:(BOOL)isShow{
    if (isShow) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor whiteColor]]];
        //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbarLine.png"] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        //        [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"tabbarLine.png"]];
    }
    //    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //    for (UIView *subView in navigationBar.subviews) {
    //            for (UIView *hairline in subView.subviews) {
    //                if ([hairline isKindOfClass:[UIImageView class]] && hairline.height <= 1.0) {
    ////                    UIImageView *lineImage = (UIImageView *)hairline;
    ////                    lineImage.height = 5;
    ////                    lineImage.image = [UIImage new];
    //                    hairline.backgroundColor = [UIColor colorWithRGBHex:0xdddddd];
    //                    hairline.hidden = isHiden;
    //                }
    //            }
    //        }
}

- (void)setBackBarButtonItem:(UIColor*)color{
    //    if (IS_IOS_10) {
    UIButton* backBtn = [UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
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

- (void)backBtn{
    if (_backBlock) {       //有block执行block返回事件
        _backBlock(self);
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color{
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

- (void)dealloc{
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
