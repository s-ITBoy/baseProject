//
//  SSsecondVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSsecondVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SSsecondVC ()
@property(nonatomic,strong) UITextField* inputTF;
@property(nonatomic,strong) UILabel* testLab;
@end

@implementation SSsecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTF = [[UITextField alloc] initWithFrame:CGRectMake(ssscale(50), ssscale(50), ScreenWidth-2*ssscale(50), ssscale(45))];
    self.inputTF.placeholder = @"请输入内容!";
    [self.view addSubview:self.inputTF];
    
    self.testLab = [[UILabel alloc] initWithFrame:CGRectMake(self.inputTF.XX, CGRectGetMaxY(self.inputTF.frame)+ssscale(5), self.inputTF.width, ssscale(30))];
    [self.view addSubview:self.testLab];
    
    
    [self.inputTF.rac_textSignal subscribeNext:^(id x) {
        if (![SShelper isObjNil:x]) {
            NSLog(@"-------- 信号x = %@",x);
        }
    }];
    
    [[[self.inputTF.rac_textSignal filter:^BOOL(NSString* value) {
        return value.length>3 ? YES : NO;
    }]map:^id(NSString* value) {
        return value.length > 4?[UIColor redColor]:[UIColor whiteColor];
    }]subscribeNext:^(UIColor* x) {
        self.inputTF.backgroundColor = x;
    }];
    
    RACSignal *validUserNameSignal = [self.inputTF.rac_textSignal map:^id(id value) {
        if ([value length] > 4) {
            return @(1);
        }else {
            return @(0);
        }
    }];

    RAC(self.testLab, backgroundColor) = [validUserNameSignal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor groupTableViewBackgroundColor];
    }];
    
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
