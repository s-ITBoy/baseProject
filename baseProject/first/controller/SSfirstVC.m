//
//  SSfirstVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSfirstVC.h"
#import "SSfileManager.h"
#import "SSnaviAndStatusBarV.h"

@interface SSfirstVC ()
@property(nonatomic,strong) UILabel* valueLab;
@end

@implementation SSfirstVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.hidden == NO) {
//        self.navigationController.navigationBar.hidden = YES;
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.title = @"首页";
    SSnaviAndStatusBarV* navi = [[SSnaviAndStatusBarV alloc] init];
    navi.frame = CGRectMake(0, 0, ScreenWidth, NAVIHEIGHT);
    navi.type = SSnaviTypeShowDefault;
    navi.naviBlock = ^(NSInteger index) {
        NSLog(@"----- index = %ld",index);
    };
    
//    navi.titleStr = @"首页";
    [self.view addSubview:navi];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:SSlocalStr(@"home", nil) forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    /// slfjweofwofjslfjs
    
    
    
}

- (void)clickBtn {
//    self.hidesBottomBarWhenPushed = YES;
    [self SS_pushVCWithClassStr:@"SSwebVC" withPropertyDic:@{@"urlString":@"https://www.baidu.com"}];
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
