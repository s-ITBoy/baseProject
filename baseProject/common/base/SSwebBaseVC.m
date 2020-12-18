//
//  SSwebBaseVC.m
//  baseProject
//
//  Created by F S on 2017/8/27.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSwebBaseVC.h"
#import <WebKit/WebKit.h>

@interface SSwebBaseVC ()<UIGestureRecognizerDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong) WKWebView* wkWebView;
@property(nonatomic,strong) UIProgressView* progress;
@end

@implementation SSwebBaseVC
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIHEIGHT)];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
    }
    return _wkWebView;
}
- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ssscale(2))];
        _progress.backgroundColor = [UIColor whiteColor];
        _progress.progressTintColor = [UIColor greenColor];
        _progress.hidden = YES;
    }
    return _progress;
}

///FIXME:----------
//- (void)loadView {
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    _wkWebView = [[WKWebView alloc] initWithFrame: [UIScreen mainScreen].bounds configuration:config];
////    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT, ScreenWidth, ScreenHeight-NAVIHEIGHT) configuration:config];
//    _wkWebView.allowsBackForwardNavigationGestures = YES;
//    _wkWebView.UIDelegate = self;
//    _wkWebView.navigationDelegate = self;
////        [self addJS];
//    self.view = _wkWebView;
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == YES) {
        self.navigationController.navigationBar.hidden = NO;
    }
    if ([SShelper isObjNil:self.wkWebView.title]) {
        self.progress.hidden = NO;
        [self.wkWebView reload];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progress];
    
    if (self.urlString && [self.urlString hasPrefix:@"http"]) {
        NSURL* url = [NSURL URLWithString:self.urlString];
        NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
        [self.wkWebView loadRequest:request];
    }
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    if (IS_IOS_VERSION < 9.0) {
        [self.wkWebView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //网页title
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView) {
            self.navigationItem.title = self.wkWebView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
     }else if ([keyPath isEqualToString:@"URL"]) {
         if (object == self.wkWebView) {
             NSURL* newUrl = [change objectForKey:NSKeyValueChangeNewKey];
             NSURL* oldUrl = [change objectForKey:NSKeyValueChangeOldKey];
             if ([SShelper isObjNil:newUrl] && ![SShelper isObjNil:oldUrl]) {
                 [self.wkWebView reload];
             }
         }
     }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
         self.progress.progress = self.wkWebView.estimatedProgress;
         if (self.progress.progress == 1) {
             self.progress.hidden = YES;
//             __weak typeof (self)weakSelf = self;
//             [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                 weakSelf.progress.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
//             } completion:^(BOOL finished) {
//                 weakSelf.progress.hidden = YES;
//
//             }];
         }
     }
     else {
         [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
     }
}

#pragma mark --------- WKWebView --------------
#pragma mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progress.hidden = NO;
    SSLog(@"----------- start ---------");
    SSLog(@"----------- URL = %@ ",webView.URL);
    SSLog(@"----------- start ---------");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progress.hidden = YES;
    self.navigationItem.title = webView.title;
    //加载完成后隐藏progressView
    //JS注入
    SSLog(@"----------- finish ---------");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progress.hidden = YES;
    //加载失败同样需要隐藏progressView
    SSLog(@"----------- fail ---------");
    SSLog(@"----------- fail url = %@",webView.URL);
    SSLog(@"----------- fail ---------");
//    [webView stopLoading];
    if ([error code] == NSURLErrorCancelled) {
       return;
    }
    if ([error code] == NSURLErrorSecureConnectionFailed) {
        return;
    }
}

///页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler {
//    NSString* url = [navigationAction.request.URL absoluteString];
//    NSLog(@"-------- 跳转URL= %@",url);
    
    //允许页面跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macos(10.11), ios(9.0)) {
    self.progress.hidden = NO;
    [webView reload];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    SSLog(@"-----------message.name = %@",message.name);
//    if ([message.name isEqualToString:@"lingqu"]) {
//        id object = message.body;
//        SSLog(@"-------- message.body = %@",object);
//        if ([object isKindOfClass:[NSString class]]) {
//            NSDictionary* dic = [object ss_dicFromStr];
//            SSLog(@"------- dic = \n%@",dic);
//            [self loadNativeAd:dic];
//            dic = nil;
//        }
//    }
}

- (void)back {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtn {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        return;
    }
    [super backBtn];
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
