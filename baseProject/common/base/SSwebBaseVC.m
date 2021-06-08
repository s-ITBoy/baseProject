//
//  SSwebBaseVC.m
//  baseProject
//
//  Created by F S on 2017/8/27.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSwebBaseVC.h"
#import "SSnaviAndStatusBarV.h"

@interface SSwebBaseVC ()<UIGestureRecognizerDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong) WKWebView* wkWebView;
@property(nonatomic,strong) UIProgressView* progress;

@property(nonatomic,strong) SSnaviAndStatusBarV* customNavi;
@end

@implementation SSwebBaseVC
#pragma mark ------ 懒加载 -----------
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
        _progress.progressTintColor = [UIColor blueColor];
//        _progress.hidden = YES;
    }
    return _progress;
}
- (SSnaviAndStatusBarV *)customNavi {
    if (!_customNavi) {
        _customNavi = [[SSnaviAndStatusBarV alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIHEIGHT)];
        _customNavi.backgroundColor = [UIColor whiteColor];
        weakly(self);
        _customNavi.naviBlock = ^(NSInteger index) {
            [weakSelf naviCLick:index];
        };
    }
    return _customNavi;
}

///FIXME:----------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.hidden == YES) {
//        self.navigationController.navigationBar.hidden = NO;
//    }
    if ([SShelper isObjNil:self.wkWebView.title]) {
        self.progress.hidden = !self.isShowProgress;
        [self.wkWebView reload];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowProgress = YES;
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progress];
    
    if (self.urlString && [self.urlString hasPrefix:@"http"]) {
        NSURL* url = [NSURL URLWithString:self.urlString];
        NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
//        NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60*60*24];
        [self.wkWebView loadRequest:request];
        
    }
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    if (IS_IOS_VERSION < 9.0) {
        [self.wkWebView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)addJS {
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"lingqu"];
}

///KVO
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
    self.progress.hidden = !self.isShowProgress;
    NSLog(@"------start----- URL = %@ ",webView.URL);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progress.hidden = YES;
    if (self.isUseCustomNavi) {
        self.customNavi.titleStr = webView.title;
    }else {
        self.navigationItem.title = webView.title;
    }
    if (self.ss_didfinishLoading) {
        self.ss_didfinishLoading(webView, navigation);
    }
    //加载完成后隐藏progressView
    //JS注入
    NSLog(@"----------- finish ---------");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progress.hidden = YES;
    //加载失败同样需要隐藏progressView
    NSLog(@"----------- fail url = %@",webView.URL);
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
    if (self.isUseCustomNavi) {
        //当webView.canGoBackwe = YES时显示关闭按钮
        self.customNavi.isShowCloseBtn = webView.canGoBack;
    }
    NSString* url = [navigationAction.request.URL absoluteString];
    NSLog(@"-------- 跳转URL= %@",url);
    if (self.ss_decidePolicyForNavigationAction) {
        self.ss_decidePolicyForNavigationAction(webView, decisionHandler);
    }
    //允许页面跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macos(10.11), ios(9.0)) {
    self.progress.hidden = !self.isShowProgress;
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

#pragma mark ------ 参数设置 --------
- (void)setIsUseCustomNavi:(BOOL)isUseCustomNavi {
    _isUseCustomNavi = isUseCustomNavi;
    self.navigationController.navigationBar.hidden = isUseCustomNavi;
    if (isUseCustomNavi) {
        [self.view addSubview:self.customNavi];
        self.wkWebView.YY = -statusBarHeight;
        self.wkWebView.height = ScreenHeight + statusBarHeight;
    }else {
        self.wkWebView.YY = 0;
        self.wkWebView.height = ScreenHeight - NAVIHEIGHT;
    }
}

- (void)setIsShowProgress:(BOOL)isShowProgress {
    _isShowProgress = isShowProgress;
    self.progress.hidden = !isShowProgress;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    self.progress.progressTintColor = progressTintColor;
}

- (void)setProgressYY:(CGFloat)progressYY {
    _progressYY = progressYY;
    self.progress.YY = progressYY;
}

- (void)naviCLick:(NSInteger)index {
    switch (index) {
        case 0:
            [self ss_backBtn];
            break;
        case 1:
            break;
        case 2:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

- (void)back {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ss_backBtn {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        return;
    }
    [super ss_backBtn];
}

- (void)dealloc {
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate = nil;
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
