//
//  SSwebVC.m
//  baseProject
//
//  Created by apple on 2021/6/8.
//  Copyright © 2021 FL S. All rights reserved.
//

#import "SSwebVC.h"

@interface SSwebVC ()

@end

@implementation SSwebVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
//    [self setValue:@(ScreenHeight) forKeyPath:@"wkWebView.height"];
    [super viewDidLoad];
    self.isUseCustomNavi = YES;
    self.isShowProgress = YES;
    self.ss_didfinishLoading = ^(WKWebView * _Nonnull webView, WKNavigation * _Nonnull navigation) {
        NSLog(@"---- url = %@",webView.URL);
    };
    self.ss_decidePolicyForNavigationAction = ^(WKWebView * _Nonnull webView, decisionHandler  _Nonnull handler) {
        
    };
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
