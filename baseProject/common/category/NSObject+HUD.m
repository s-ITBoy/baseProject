//
//  NSObject+HUD.m
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import "NSObject+HUD.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "SSshowContentView.h"

#define KEY_OBJECT_HUD @"UIViewController.HBHUD"
#define KEY_HUD @"dismissblock"

@implementation NSObject (HUD)

static char OperationKey;

#pragma mark --------- 自定义 SSshowContentView -------------
- (void)SSshowCustomWithMsg:(NSString*)msg {
    SSshowContentView* show = [[SSshowContentView alloc] init];
    [show SSshowCustomWithMsg:msg];
}

- (void)SSshowCustomWithMsg:(NSString*)msg dismissBlock:(void (^)(void))disBlock {
    SSshowContentView* show = [[SSshowContentView alloc] init];
    [show SSshowMsg:msg FinishBlock:disBlock];
}


#pragma mark --------- HUD -------------
-(void)presentMessageTips:(NSString *)message{
    [self presentMessageTips_:message];
}

-(void)presentMessageTips_:(NSString *)message{
    UIView * superview = [self SuperView];
    if(!superview) return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.label.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.margin = 5;
    hud.minShowTime = 0.6;
//    CGPoint point = hud.offset;
//    point.y = 0;
//    hud.offset = point;
    
    [hud hideAnimated:YES afterDelay:0.5];
}

-(void)presentMessageTips:(NSString *)message dismisblock:(void (^)(void))dismissblock{
    [self presentMessageTips_:message dismisblock:dismissblock];
}

- (void)presentMessageTips_:(NSString *)message dismisblock:(void(^)(void))dismissblock {
    UIView * superview = [self SuperView];
    if(!superview) return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.label.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.margin = 5;
    hud.minShowTime = 0.6;
//    CGPoint point = hud.offset;
//    point.y = 0;
//    hud.offset = point;
    
    [hud hideAnimated:YES afterDelay:0.5];
    hud.completionBlock = ^{
        dismissblock();
    };
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    [hud showAnimated:YES whileExecutingBlock:^{
//        [self myTask];
//    } onQueue:queue completionBlock:^{
//
//        [hud removeFromSuperview];
//        dismissblock();
//    }];
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud hide:YES afterDelay:1];
//             dismissblock();
//        });
}




- (void)presentMessageTips_:(NSString *)message duration:(CGFloat)duration dismisblock:(void (^)(void))dismissblock{
    UIView * superview = [self SuperView];
    if(!superview) return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.margin = 10.f;
    CGPoint point = hud.offset;
    point.y = 55.f;
    hud.offset = point;
    hud.minShowTime = duration;
    
    [hud hideAnimated:YES afterDelay:0.5];
    hud.completionBlock = ^{
        dismissblock();
    };
}

-(MBProgressHUD *)presentLoadingTips:(NSString *)message {
    UIView * superview = [self SuperView];
    if(!superview) return nil;
    MBProgressHUD * HUD =  [MBProgressHUD showHUDAddedTo:superview animated:YES];//[[MBProgressHUD alloc] initWithView:superview];
    HUD.mode = MBProgressHUDModeIndeterminate;//MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.label.text = message;
    [self setHUD:HUD];
    return HUD;
}

-(void)presentLoadinghud{
    UIView * superview = [self SuperView];
    if(!superview) return ;
//    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:superview animated:false];
    [MBProgressHUD showHUDAddedTo:superview animated:false];
    
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.backgroundView.backgroundColor = UIColor.whiteColor;
//    hud.top = NAVIHEIGHT;
//    hud.height = ScreenHeight-NAVIHEIGHT;
//
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = UIColor.clearColor;
//    NSMutableArray *images = [NSMutableArray new];
//    for (int i = 1; i <= 12; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"houziloading_0000%0.2d",i]];
//        [images addObject:image];
//    }
//    UIImageView *loadingView = [[UIImageView alloc] initWithImage:images[0]];
//    //        UIImageView *loadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//            loadingView.animationImages = images;
//            loadingView.animationDuration = 0.04*images.count;
//            [loadingView startAnimating];
//    hud.label.text = @"努力加载中...";
//    hud.customView = loadingView;
}

-(void)dismissAllTips {
    UIView * superview = [self SuperView];
    if(!superview) return ;
    [MBProgressHUD hideHUDForView:superview animated:YES];
}

-(void)dismissTips {
    MBProgressHUD * hud = [self HUD];
    [hud hideAnimated:YES];
}


- (void)myTask {
    sleep(1);
}
- (void)myProgressTask {    
    MBProgressHUD * hud = [self HUD];
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        hud.progress = progress;
        usleep(50000);
    }
}

-(void)setHUD:(MBProgressHUD *)HUD{
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    if(opreations == nil){
        opreations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, opreations, OBJC_ASSOCIATION_RETAIN);
    }
    [opreations setObject:HUD forKey:KEY_HUD];
}

-(MBProgressHUD *)HUD{
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    if(opreations == nil) return nil;
    MBProgressHUD * aHUD = [opreations objectForKey:KEY_HUD];
    return aHUD;
}

-(UIView *)SuperView{
    UIView * superview = nil;
    if ([[self class] isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController * ctr = (UINavigationController *)self;
        superview = ctr.view;
    }
    else if ([[self class] isSubclassOfClass:[UIViewController class]]) {
        UIViewController * ctr = (UIViewController *)self;
        superview = ctr.view;
    }
    else if ([[self class] isSubclassOfClass:[UIView class]]) {
        //        UIView * ctr = (UIView *)self;
        //        superview = ctr;
        superview = [UIApplication sharedApplication].keyWindow;
    }
    else if ([[self class] isSubclassOfClass:[UIWindow class]]) {
        UIWindow * ctr = (UIWindow *)self;
        superview = ctr;
        
    }
    else if ([[self class] isSubclassOfClass:[AppDelegate class]]) {
        AppDelegate * ctr = (AppDelegate *)self;
        superview = ctr.window;
    }else{
        superview = [UIApplication sharedApplication].keyWindow;
    }
    return superview;
}

@end
