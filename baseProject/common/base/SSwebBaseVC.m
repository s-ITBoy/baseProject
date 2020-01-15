//
//  SSwebBaseVC.m
//  leeMail
//
//  Created by F S on 2019/7/16.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSwebBaseVC.h"
#import <WebKit/WebKit.h>

@implementation SSjsObject
- (void)toCopy:(NSString *)message {
    [self.delegate toCopy:message];
}

@end
@interface SSwebBaseVC ()<UIWebViewDelegate,SSjsObjectDelegate>
//@property(nonatomic,strong) WKWebView* wkWebView;
@property(nonatomic,strong) UIWebView* webView;

@property(nonatomic,strong) JSContext* context;
@property(nonatomic,strong) SSjsObject* jsObject;

@end

@implementation SSwebBaseVC
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, statusBarHeight+NaviBarHeight, ScreenWidth, ScreenHeight-NAVIHEIGHT)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == YES) {
        self.navigationController.navigationBar.hidden = NO;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    if (self.urlString && [self.urlString hasPrefix:@"http"]) {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [self.webView loadRequest:request];
    }
    
}

- (void)backBtn {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    [super backBtn];
}

#pragma mark ----- UIWebViewDelegate ------
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self presentLoadinghud];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self dismissAllTips];
    SSLog(@"---- nsthread  = %@",[NSThread currentThread]);
    NSString *navigationTitle =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = navigationTitle;
    weakly(self);
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    self.jsObject = [[SSjsObject alloc] init];
//    self.jsObject.delegate = self;
    self.context[@"toGOMoney"] = ^() {
//           SSLog(@"-----   成功111111  -----");
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.tabBarController.selectedIndex = 1;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
       };
    
    //              window.webkit.messageHandlers.showInfoFromJs.postMessage(name);
    self.context[@"showInfoFromJs"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue* value in args) {
//            SSLog(@"-----  value = %@",[value toString]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf copYStr:[value toString]];
            });
        }
    };
//    self.context[@"toCopy"] = ^() {
//        SSLog(@"--- arr = ");
//    };
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self dismissTips];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    SSLog(@"---- webUrl = \n%@",request.URL);
    NSString* url = [request.URL absoluteString];
    SSLog(@"--- url = \n%@",url);
    NSDictionary* dic = [self getParamsWithUrlString:url];
    SSLog(@"----- dic = %@",[dic SSdictionryToJSONString]);
//    if ([dic.allKeys containsObject:@"goodsId"]) {
//        SSDetailVC* detail = [[SSDetailVC alloc] init];
//        detail.goodId = [NSString stringWithFormat:@"%@",dic[@"goodsId"]];
//        detail.isHide = @"0";
//        [self.navigationController pushViewController:detail animated:YES];
//        return NO;
//    }
    return YES;
}

- (void)toCopy:(NSString *)message {
    [self presentMessageTips:@"000000"];
    SSLog(@"------   成功   --------");
}

- (void)copYStr:(NSString*)str {
    [SShelper SScopyStr:str];
}

/**
 获取url中的参数并返回
 @param urlString 带参数的url
 @return @[NSString:无参数url, NSDictionary:参数字典]
 */

- (NSDictionary*)getParamsWithUrlString:(NSString*)urlString {
    if(urlString.length==0) {
//        SSLog(@"链接为空！");
        return @{};
    }
    //先截取问号
    NSArray*allElements = [urlString componentsSeparatedByString:@"?"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    if(allElements.count==2) {
        //有参数或者?后面为空
//        NSString*myUrlString = allElements[0];
        NSString*paramsString = allElements[1];
        //获取参数对
        NSArray*paramsArray = [paramsString componentsSeparatedByString:@"&"];
        if(paramsArray.count>=2) {
            for(NSInteger i =0; i < paramsArray.count; i++) {
                NSString*singleParamString = paramsArray[i];
                NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                if(singleParamSet.count==2) {
                    NSString*key = singleParamSet[0];
                    
                    NSString*value = singleParamSet[1];
                    if(key.length>0|| value.length>0) {
                        [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                    }
                }
            }
        }else if(paramsArray.count==1) {
            //无 &。url只有?后一个参数
            NSString*singleParamString = paramsArray[0];
            NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            if(singleParamSet.count==2) {
                NSString*key = singleParamSet[0];
                NSString*value = singleParamSet[1];
                if(key.length>0|| value.length>0) {
                    [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                }
            }else{
                //问号后面啥也没有 xxxx?  无需处理
            }
        }
        return params;
    }else if(allElements.count>2) {
//        SSLog(@"链接不合法！链接包含多个\"?\"");
        return @{};
    }else{
//        SSLog(@"链接不包含参数！");
        return @{};
    }
}

- (void)dealloc {
    self.webView.delegate = nil;
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
