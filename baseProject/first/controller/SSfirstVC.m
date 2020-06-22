//
//  SSfirstVC.m
//  baseProject
//
//  Created by F S on 2020/1/16.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSfirstVC.h"
#import "SSBtnsListView.h"

@interface SSfirstVC ()
@property(nonatomic,strong) SSBtnsListView* btnsListV;
@end

@implementation SSfirstVC
- (SSBtnsListView *)btnsListV {
    if (!_btnsListV) {
        _btnsListV = [[SSBtnsListView alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT, ScreenWidth, ssscale(44))];
        _btnsListV.titleArray = @[@"123",@"234",@"345",@"456"];
        _btnsListV.sliderWidth = ssscale(30);
    }
    return _btnsListV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.btnsListV];
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
