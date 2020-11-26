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

-(void)presentMessageTips:(NSString *)message{
    [self presentMessageTips_:message];
}


-(void)presentMessageTips:(NSString *)message dismisblock:(void (^)(void))dismissblock{
    [self presentMessageTips_:message dismisblock:dismissblock];
}


-(void)presentFailureTips:(NSString *)message{
    [self presentMessageTips_:message];
}

-(void)presentMessageTips_:(NSString *)message{
    SSshowContentView* tip = [[SSshowContentView alloc] init];
    tip.tip = message;
    [tip show];
    
//    UIView * superview = [self SuperView];
//    if(!superview) return;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
//    hud.userInteractionEnabled = false;
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
////    hud.labelText = message;
//    hud.label.text = message;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.margin = 10.f;
//
////    hud.yOffset = 0;
//    CGPoint point = hud.offset;
//    point.y = 0;
//    hud.offset = point;
//    hud.removeFromSuperViewOnHide = YES;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [hud hide:YES];
//        [hud hideAnimated:YES];
//    });
}




- (void)presentMessageTips_:(NSString *)message duration:(CGFloat)duration dismisblock:(void (^)(void))dismissblock{
    UIView * superview = [self SuperView];
    if(!superview) return;
    //    superview = superview.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
//    hud.labelText = message;
    hud.label.text = message;
    hud.margin = 10.f;
//    hud.yOffset = 55.f;
    CGPoint point = hud.offset;
    point.y = 55.f;
    hud.offset = point;
    hud.minShowTime = duration;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [hud showAnimated:YES whileExecutingBlock:^{
        [self myTask];
    } onQueue:queue completionBlock:^{
        
        [hud removeFromSuperview];
        dismissblock();
    }];
}

- (void)presentMessageTips_:(NSString *)message dismisblock:(void(^)(void))dismissblock {
    UIView * superview = [self SuperView];
    if(!superview) return;
    //    superview = superview.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
//    hud.labelText = message;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:1];
    hud.margin = 10.f;
//    hud.yOffset = 0;
    CGPoint point = hud.offset;
    point.y = 0;
    hud.offset = point;
//    hud.removeFromSuperViewOnHide = YES;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [hud showAnimated:YES whileExecutingBlock:^{
        [self myTask];
    } onQueue:queue completionBlock:^{
        
        [hud removeFromSuperview];
        dismissblock();
    }];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [hud hide:YES afterDelay:1];
    //         dismissblock();
    //    });
}

//- (void)presentLoadingTips:(NSString *)message dismisblock:(void(^)())dismissblock
//{
//
//    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    [self setHUD:HUD];
//
//    // Set determinate mode
//    HUD.mode = MBProgressHUDModeDeterminate;
//
//    HUD.delegate = self;
//    HUD.labelText = message;
//    // myProgressTask uses the HUD instance to update progress
//    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
//}

-(void)presentLoadinghud{
    UIView * superview = [self SuperView];
    if(!superview) return ;
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
//    [MBProgressHUD hideAllHUDsForView:superview animated:YES];
    [MBProgressHUD hideHUDForView:superview animated:YES];
}

-(MBProgressHUD *)presentLoadingTips:(NSString *)message {

    UIView * superview = [self SuperView];
    if(!superview) return nil;
    MBProgressHUD * HUD =  [MBProgressHUD showHUDAddedTo:superview animated:YES];//[[MBProgressHUD alloc] initWithView:superview];
    //    [superview addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeIndeterminate;//MBProgressHUDModeDeterminate;
    HUD.delegate = self;
//    HUD.labelText = message;
    HUD.label.text = message;
    [self setHUD:HUD];
    return HUD;
}


-(void)dismissTips {
    MBProgressHUD * hud = [self HUD];
//    [hud hide:YES];
    [hud hideAnimated:YES];
}


- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(1);
}
- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    
    MBProgressHUD * hud = [self HUD];
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        hud.progress = progress;
        usleep(50000);
    }
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

@end
