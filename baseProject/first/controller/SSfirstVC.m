//
//  SSfirstVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSfirstVC.h"
#import "SSfileManager.h"
#import "AppDelegate.h"

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
    self.navigationItem.title = @"首页";
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:SSlocalStr(@"home", nil) forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"path = \n%@",[@"" ss_moneyStr]);
    
}

- (void)clickBtn {
//    self.hidesBottomBarWhenPushed = YES;
    [self SS_pushVCWithClassStr:@"SSthirdVC" withPropertyDic:nil];
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
