//
//  SSsecondVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSsecondVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SScaculatorMaker.h"

@interface SSsecondVC ()
@property(nonatomic,strong) UITextField* nameTF;
@property(nonatomic,strong) UITextField* passwdTF;
@property(nonatomic,strong) UIButton* loginBtn;
@end

@implementation SSsecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(ssscale(50), ssscale(50), ScreenWidth-2*ssscale(50), ssscale(45))];
    self.nameTF.placeholder = @"请输入用户名!";
    self.nameTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nameTF];
    
    self.passwdTF = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTF.XX, CGRectGetMaxY(self.nameTF.frame)+ssscale(5), self.nameTF.width, ssscale(30))];
    self.passwdTF.placeholder = @"请输入密码!";
    self.passwdTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.passwdTF];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginBtn.frame = CGRectMake(self.nameTF.XX, CGRectGetMaxY(self.passwdTF.frame)+ssscale(20), self.nameTF.width, ssscale(35));
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
//    self.loginBtn.userInteractionEnabled = NO;
//    [self.loginBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
//    int result = [NSObject makeCaculators:^(SScaculatorMaker * _Nonnull maker) {
//        maker.add(1).add(2).add(3).add(4).add(5);
////        [maker add];
////        maker.add;
//    }];
//    NSLog(@"------ result = %d",result);
        
    [self rac_test4];
    
    
}

- (void)clickBtn {
    NSLog(@"---------点击了按钮 ");
    
}

- (void)httpRequestData {
    [[SShttprequest shareRequest] httpRequest:@{} urlString:[ServerHost stringByAppendingString:@"/duoduoke/icon_list"] method:HttpRequestMethodGet showLoading:NO showFailure:YES resultHandler:^(BOOL isOK, id  _Nonnull responseOnject) {
        if (isOK) {
//            NSArray* dataArr = [[responseOnject SSdicForDicKey:@"data"] SSarrayForDicKey:@"list"];
        }
    }];
}


- (void)rac_test4 {
    RACSignal* loginSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[SShttprequest shareRequest] httpRequest:@{} urlString:[ServerHost stringByAppendingString:@"/duoduoke/icon_list"] method:HttpRequestMethodGet showLoading:NO showFailure:YES resultHandler:^(BOOL isOK, id  _Nonnull responseOnject) {
            if (isOK) {
                NSArray* dataArr = [[responseOnject SSdicForDicKey:@"data"] SSarrayForDicKey:@"list"];
                NSLog(@"------ dataArr = \n%@",[dataArr SSarrayToJSONString]);
                [subscriber sendNext:dataArr];
            }else {
                [subscriber sendNext:@""];
            }
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    [[[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        NSLog(@"-------- x = %@",x);
    }] flattenMap:^RACStream *(id value) {
        NSLog(@"-------- value = %@",value);
        return loginSignal;
    }] subscribeNext:^(id x) {
        NSLog(@"-------- xxx : \n%@",x);
    } error:^(NSError *error) {
        
    }];
}

- (void)rac_test3 {
    RACSignal* nameSignal = [self.nameTF.rac_textSignal map:^id(NSString* __nullable value) {
        return @([SShelper isValidPhoneeNumber:value]);
    }];
    
    RACSignal* passwdSignal = [self.passwdTF.rac_textSignal map:^id(NSString* _Nullable value) {
        return @([self isValid:value]);
    }];
    
    [[RACSignal combineLatest:@[nameSignal, passwdSignal] reduce:^id(id name, id passwd){
//        return @(name && passwd);
        return @([name boolValue] && [passwd boolValue]);
    }] subscribeNext:^(id x) {
        self.loginBtn.userInteractionEnabled = [x boolValue];
    }];
    
}

- (BOOL)isValid:(NSString *)str {
    /*
     给密码定一个规则：由字母、数字和_组成的6-16位字符串
     */
    NSString *regularStr = @"[a-zA-Z0-9_]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}

- (void)rac_test2 {
    RACSignal *validUserNameSignal = [self.nameTF.rac_textSignal map:^id(id value) {
        if ([value length] > 4) {
            return @(1);
        }else {
            return @(0);
        }
    }];

    RAC(self.passwdTF, backgroundColor) = [validUserNameSignal map:^id _Nullable(id  _Nullable value) {
        self.nameTF.backgroundColor = [value boolValue] ? [UIColor whiteColor] : [UIColor redColor];
        return [value boolValue] ? [UIColor clearColor] : [UIColor groupTableViewBackgroundColor];
    }];
}

- (void)rac_test1 {
    [self.nameTF.rac_textSignal subscribeNext:^(id x) {
        if (![SShelper isObjNil:x]) {
            NSLog(@"-------- 信号x = %@",x);
        }
    }];

    [[[self.nameTF.rac_textSignal filter:^BOOL(NSString* value) {
        return value.length>3 ? YES : NO;
    }]map:^id(NSString* value) {
        return value.length > 4?[UIColor redColor]:[UIColor whiteColor];
    }]subscribeNext:^(UIColor* x) {
        self.nameTF.backgroundColor = x;
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
