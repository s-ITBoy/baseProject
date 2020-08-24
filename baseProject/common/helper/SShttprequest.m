//
//  SShttprequest.m
//  leeMail
//
//  Created by F S on 2017/7/5.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SShttprequest.h"
#import "SSbaseNavigationC.h"
//#import "SSLoginVC.h"
//#import "SSuserModel.h"

@interface SShttprequest ()
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionManager;

@end

@implementation SShttprequest

+(SShttprequest*)shareRequest {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(AFHTTPSessionManager *)httpSessionManager{
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//        _httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_httpSessionManager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"clientType"];
        
//        [_httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [_httpSessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_httpSessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain",@"text/javascript", nil];
        
//        [_httpSessionManager.requestSerializer setValue:@"Bearer" forHTTPHeaderField:@"authorization"];
        
        _httpSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _httpSessionManager.requestSerializer.timeoutInterval = 20;
//                _httpSessionManager.securityPolicy.allowInvalidCertificates = true;
        _httpSessionManager.securityPolicy.validatesDomainName = NO;
        
        
    }
    return _httpSessionManager;
}


- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method  showLoading:(BOOL)showLoading showFailure:(BOOL)show resultHandler:(void(^)(BOOL isOK, id responseOnject))handler {
//    SSLog(@"------ params = \n%@",[parameters SSdictionryToJSONString]);
    if (showLoading) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentLoadinghud];
        });
//        [self presentLoadinghud];
    }
    NSString* tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:token];
    if ([SShelper isObjNil:tokenStr]) {
        tokenStr = @"";
    }else {
        tokenStr = [NSString stringWithFormat:@"Bearer %@",tokenStr];
        SSLog(@"------ token = \n%@",tokenStr);
    }
    if (tokenStr.length) {
//        [self.httpSessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:token];
        [self.httpSessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"authorization"];
    }
    
    switch (method) {
        case HttpRequestMethodGet:
            [self GET:parameters urlString:urlString isShowFailture:show resultHandler:handler];
            break;
        case HttpRequestMethodPost:
            [self POST:parameters urlString:urlString isShowFailture:show resultHandler:handler];
            break;
//        case HttpRequestMethodUPLOAD:
//            [self UPLOAD:parameters urlString:urlString isShowFailture:show pictureData:pictureDatas name:name sucessHandler:handler failtureHandler:failtureHandler];
            
        default:
            break;
    }
}

///FIXME: post请求
- (void)POST:(NSDictionary*)parameters urlString:(NSString*)urlString isShowFailture:(BOOL)isShowFailture resultHandler:(void(^)(BOOL isOK, id responseOnject))handler {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    });
    [self.httpSessionManager POST:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        SSLog(@"-------接口返回数据= \n%@",[responseObject SSdictionryToJSONString]);
        if ([[responseObject SSstringForDicKey:@"code"] integerValue] == 0) {
            handler(YES, [self processDictionaryIsNSNull:responseObject]);
        }else if ([[responseObject SSstringForDicKey:@"code"] integerValue] == 401) {
            ///code = 401 重新登录
            handler(NO,[responseObject SSstringForDicKey:@"message"]);
            
            [self presentMessageTips:[responseObject SSstringForDicKey:@"message"]];
//            SSuserModel* user = [SSuserModel shareModel];
//            [user deleteInfo];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//            [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
            
//            [self presentMessageTips_:[responseObject SSstringForDicKey:@"message"] duration:0.2 dismisblock:^{
//                SSuserModel* user = [SSuserModel shareModel];
//                [user deleteInfo];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
//            }];
            
//            [self presentMessageTips:@"重新登录" dismisblock:^{
//                SSuserModel* user = [SSuserModel shareModel];
//                [user deleteInfo];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
//            }];
            
        }else{
            handler(NO,[self processDictionaryIsNSNull:responseObject]);
            if (isShowFailture) {
                [self presentMessageTips:[NSString stringWithFormat:@"%@",                                          [responseObject SSstringForDicKey:@"message"]]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self dismissAllTips];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (isShowFailture) {
            [self presentMessageTips:[NSString stringWithFormat:@"%@:%ld",error.localizedDescription,(long)error.code]];
            SSLog(@"------error:%@:接口:%@ code = %ld",error.localizedFailureReason,urlString,error.code);
        }
        handler(NO,error);
    }];
}

///FIXME:get请求
- (void)GET:(NSDictionary*)parameters urlString:(NSString*)urlString isShowFailture:(BOOL)isShowFailture resultHandler:(void(^)(BOOL isOK, id responseOnject))handler {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    });
    [self.httpSessionManager GET:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
//        SSLog(@"-------接口返回数据= \n%@",[responseObject SSdictionryToJSONString]);
        if ([[responseObject SSstringForDicKey:@"code"] integerValue] == 0) {
            handler(YES,[self processDictionaryIsNSNull:responseObject]);
            
        }else if ([[responseObject SSstringForDicKey:@"code"] integerValue] == 401) {
            handler(NO,[responseObject SSstringForDicKey:@"message"]);
            
            [self presentMessageTips:[responseObject SSstringForDicKey:@"message"]];
//            [self presentMessageTips:@"重新登录!"];
//            SSuserModel* user = [SSuserModel shareModel];
//            [user deleteInfo];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//            [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
            
//            [self presentMessageTips_:[responseObject SSstringForDicKey:@"message"] duration:0.2 dismisblock:^{
//                SSuserModel* user = [SSuserModel shareModel];
//                [user deleteInfo];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
//            }];
            
//            [self presentMessageTips:@"重新登录" dismisblock:^{
//                SSuserModel* user = [SSuserModel shareModel];
//                [user deleteInfo];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:[[SSLoginVC alloc] init]] animated:YES completion:nil];
//                return ;
//            }];
            
        }else{
            handler(NO,[self processDictionaryIsNSNull:responseObject]);
            if (isShowFailture) {
                [self presentMessageTips:[responseObject SSstringForDicKey:@"message"]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        handler(NO, error);
        SSLog(@"------error:%@:接口:%@ code = %ld",error.localizedFailureReason,urlString,error.code);
        if (isShowFailture) {
            [self presentMessageTips:[NSString stringWithFormat:@"%@:%ld",error.localizedDescription,(long)error.code]];
        }
    }];
}


///上传图片（获取图片对应的path值）
- (void)uploadPhoto:(NSDictionary *)parameters urlString:(NSString *)urlString pictureData:(NSData*)pictureData name:(NSString *)name handler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id  error))failtureHandler {
    
//    NSString* tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:token];
//    if ([SShelper isObjNil:tokenStr]) {
//        tokenStr = @"";
//    }
//    if (tokenStr.length) {
//        [self.httpSessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:token];
//    }
    
    [self.httpSessionManager POST:urlString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (NSData* picData in pictureDatas) {
            NSString* fileName = [NSString stringWithFormat:@"%ld.png",time(NULL)];
            [formData appendPartWithFileData:pictureData name:name fileName:fileName mimeType:@"image/jpeg"];
//        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        failtureHandler(error);
        [self presentMessageTips:[NSString stringWithFormat:@"%@:%ld",error.localizedDescription,(long)error.code]];
        SSLog(@"----error = %ld ====== %@",(long)error.code,error.localizedFailureReason);
        SSLog(@"------error:%@:接口:%@",error.localizedFailureReason,urlString);
        
    }];
}



////FIXME:获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark 数据结果处理
- (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

///第三方微信登录所需要调用的接口(获取微信的openid和access_token等信息)
- (void)getwxLoginWithUrl:(NSString*)url result:(void(^)(BOOL isSucc, id responseOnject))handler {
    [self.httpSessionManager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        handler(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(NO, error.description);
    }];
}

///检查App Store中的版本
- (void)appstoreVersionCheck:(void (^)(id))handler{
    [self.httpSessionManager GET:@"https://itunes.apple.com/lookup?id=1479145772" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        handler(responseObject);
    } failure:nil];
}

@end
