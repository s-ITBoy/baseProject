//
//  SSfirstVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSfirstVC.h"
#import "ViewController.h"
#import "SSBtnsListView.h"
#import "SSshowContentView.h"

@interface SSfirstVC ()
@property(nonatomic,strong) SSBtnsListView* btnsListV;
@property(nonatomic,strong) UILabel* valueLab;
@end

@implementation SSfirstVC
- (SSBtnsListView *)btnsListV {
    if (!_btnsListV) {
        _btnsListV = [[SSBtnsListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ssscale(44))];
        _btnsListV.titleArray = @[@"123",@"234",@"345",@"456"];
        _btnsListV.sliderWidth = ssscale(30);
    }
    return _btnsListV;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.hidden == NO) {
//        self.navigationController.navigationBar.hidden = YES;
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
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
