//
//  SStabbarController.m
//  leeMail
//
//  Created by F S on 2017/7/5.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SStabbarController.h"
#import "SSbaseNavigationC.h"
#import "SSfirstVC.h"
#import "SSsecondVC.h"
#import "SSthirdVC.h"
#import "SSforthVC.h"

@interface SStabbarController ()<UITabBarControllerDelegate>
//@property(nonatomic,strong) SSshopCardVC* shopCar;
@end

@implementation SStabbarController

- (void)getShopCarBadge {
//    [SSusermodel isLOginBLock:^(BOOL isLogin) {
//        if (isLogin) {
//            [[SShttprequest shareRequest] httpRequest:@{} urlString:shopCarNumUrl method:HttpRequestMethodGet showLoading:NO showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
//                if ([responseOnject isKindOfClass:[NSDictionary class]]) {
//                    if ([[responseOnject stringForDicKey:@"size"] integerValue] == 0 || [YQhelper isObjNil:[responseOnject stringForDicKey:@"size"]]) {
//                        self.shopCar.tabBarItem.badgeValue = nil;
//                    }else {
//                        self.shopCar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",[responseOnject stringForDicKey:@"size"]];
//                    }
//
//                }
//            } failtureHandler:^(id  _Nonnull error) {
//
//            }];
//        }
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getShopCarBadge];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    ///当ios>=13时且未使用SceneDelegate 则iPhoneX的TabBarHeight的高度为49
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, IS_IOS_VERSION >=13 ? 83.0 : TabBarHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    SSfirstVC* home = [[SSfirstVC alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[self imageRenderOriginalWithName:@"home"] selectedImage:[self imageRenderOriginalWithName:@"home_selected"]];
    home.tabBarItem = item1;
//    //
    SSsecondVC* second = [[SSsecondVC alloc] init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"分类" image:[self imageRenderOriginalWithName:@"admit"] selectedImage:[self imageRenderOriginalWithName:@"admit_selected"]];
    second.tabBarItem = item2;
    //
    SSthirdVC* third = [[SSthirdVC alloc] init];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[self imageRenderOriginalWithName:@"activity"] selectedImage:[self imageRenderOriginalWithName:@"activity_selected"]];
    third.tabBarItem = item3;

    SSforthVC* mine = [SSforthVC new];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[self imageRenderOriginalWithName:@"mine"] selectedImage:[self imageRenderOriginalWithName:@"mine_selected"]];
    mine.tabBarItem = item5;
    
    SSbaseNavigationC* navi1 = [self getNaviWithVC:home andTag:0 andImageInset:UIEdgeInsetsMake(-2, 0, 2, 0) andTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi2 = [self getNaviWithVC:second andTag:1 andImageInset:UIEdgeInsetsMake(-2, 0, 2, 0) andTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi3 = [self getNaviWithVC:third andTag:2 andImageInset:UIEdgeInsetsMake(-2, 0, 2, 0) andTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi4 = [self getNaviWithVC:mine andTag:3 andImageInset:UIEdgeInsetsMake(-2, 0, 2, 0) andTitlePositionAdjustment:UIOffsetMake(0, -3)];
    self.delegate = self;
    self.viewControllers = @[navi1,navi2,navi3,navi4];
    self.selectedIndex = 0;
    
//    [self.tabBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.2] size:CGSizeMake(ScreenWidth, 1)]];
//    [self.tabBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(ScreenWidth, TabBarHeight)]];
//    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    self.tabBar.layer.shadowOffset = CGSizeMake(0, -2);
//    self.tabBar.layer.shadowOpacity = 0.2;
    // 适配iOS13导致的bug
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = [UIColor SScolorWithHexString:@"#FF716E"];
        self.tabBar.unselectedItemTintColor = [UIColor SScolorWithHexString:@"#555555"];
    }
    
}

- (SSbaseNavigationC*)getNaviWithVC:(SSbaseVC*)VC andTag:(NSInteger)tag andImageInset:(UIEdgeInsets)imageInset andTitlePositionAdjustment:(UIOffset)offset {
    SSbaseNavigationC* navi = [[SSbaseNavigationC alloc] initWithRootViewController:VC];
    navi.view.tag = tag;
    navi.tabBarItem.imageInsets = imageInset;
    [navi.tabBarItem setTitlePositionAdjustment:offset];
    return navi;
}


#pragma mark ----------- UITabBarControllerDelegate -----------------
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    self.title = viewController.tabBarItem.title;
    SSbaseNavigationC* navi = (SSbaseNavigationC*)viewController;
    SSLog(@"------ last = %ld",navi.view.tag);
//    switch (navi.view.tag) {
//        case 0:
//            [MobClick event:@"make_money" attributes:@{}];
//            break;
//        case 1:
//            [MobClick event:@"Admit_money" attributes:@{}];
//            break;
//        case 2:
//            [MobClick event:@"Fortune_cheats" attributes:@{}];
//            break;
//        case 3:
//            [MobClick event:@"mine" attributes:@{}];
//            break;
//
//        default:
//            break;
//    }
}

-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    SSbaseNavigationC* navi = (SSbaseNavigationC*)viewController;
    
//        if (navi.view.tag == 1 || navi.view.tag == 3) {
//            if ([SShelper isObjNil:[[NSUserDefaults standardUserDefaults] stringForKey:token]]) {
//                [self presentMessageTips:@"请先登录" dismisblock:^{
//                    SSLoginVC* login = [[SSLoginVC alloc] initWithBLock:^{
//                        if ([SShelper isObjNil:[[NSUserDefaults standardUserDefaults] stringForKey:isShow]]) {
//                            UIWindow* keywindow = [UIApplication sharedApplication].keyWindow;
//                            SSguideView* guide = [[SSguideView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//                            guide.guideDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:guideDic];
//                            [keywindow addSubview:guide];
//                            __block typeof(guide) Guide = guide;
//                            guide.SSfinishedBLock = ^{
//                                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:isShow];
//                                [Guide removeFromSuperview];
//                            };
//                        }
//                    }];
//                    [navi.topViewController presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
//                }];
//                return NO;
//            }
//        }
    return YES;
}

- (void)setTitlePositionAdjustment:(UIOffset)adjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR {
    
}

///显示图片本身的样子（而不是根据tintcolor显示图片颜色）
- (UIImage *)imageRenderOriginalWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    if (IS_IOS_VERSION >= 7.0) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}

- (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
//        CGRect rect = CGRectMake(0.0f,0.0f, size.width, size.height);
//        UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(context, color.CGColor);
//        CGContextFillRect(context, rect);
//        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return image;
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
