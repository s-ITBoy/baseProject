//
//  SShelper.m
//  baseProject
//
//  Created by FL S on 2017/12/9.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SShelper.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "SSwebBaseVC.h"
#import "SSsearchBaseVC.h"

@implementation SShelper {
    NSMutableDictionary *_fmtters;
}

+ (instancetype)shareHelp {
    static SShelper* help = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [[SShelper alloc] init];
    });
    return help;
}

- (NSDateFormatter *)fmtterForStyle:(SSDateFormatterStyle)style {
    NSString *fmt = nil;
    switch (style) {
        case SSDateFormatterStyleDefault:
            fmt = @"yyyy-MM-dd HH:mm:ss";
            break;
        case SSDateFormatterStyle_2:
            fmt = @"yyyy/MM/dd HH:mm:ss";
            break;
        case SSDateFormatterStyle_3:
            fmt = @"dd/MM/yyyy";
            break;
        case SSDateFormatterStyle_4:
            fmt = @"yyyy-MM-dd";
            break;
        case SSDateFormatterStyle_5:
            fmt = @"yyyy年MM月dd日";
            break;
        case SSDateFormatterStyle_6:
            fmt = @"yyyy/MM/dd HH:mm";
            break;
        case SSDateFormatterStyle_7:
            fmt = @"HH:mm:ss";
            break;
        case SSDateFormatterStyle_8:
            fmt = @"mm:ss";
            break;
        case SSDateFormatterStyle_9:
            fmt = @"ss";
            break;
        case SSDateFormatterStyle_10:
            fmt = @"yyyy/MM/dd";
            break;
        case SSDateFormatterStyle_11:
            fmt = @"MM月dd日";
            break;
        case SSDateFormatterStyle_12:
            fmt = @"yyyyMMdd_HHmmss";
            break;
        case  SSDateFormatterStyle_13:
            fmt = @"HHmmss";
            break;
        case SSDateFormatterStyle_14:
            fmt = @"yyyy.MM.dd HH:mm:ss";
            break;
        case SSDateFormatterStyle_15:
            fmt = @"MM-dd";
            break;
        case SSDateFormatterStyle_16:
            fmt = @"yyyyMMdd";
            break;
        default:
            break;
    }
    NSDateFormatter *fmtter = [_fmtters objectForKey:fmt];
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
        fmtter.dateFormat = fmt;
        fmtter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_fmtters setObject:fmtter forKey:fmt];
    }
    return fmtter;
}

///将时间戳转换成指定时间格式的字符串(当时间戳为13位时需除以1000)
+ (NSString*)stringFromeTimeInterval:(NSString*)timeStamp with:(SSDateFormatterStyle)type {
    NSTimeInterval timeInterval = [timeStamp doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    //    NSDate* d = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    NSDateFormatter* formatter = [[SShelper shareHelp] fmtterForStyle:type];
    //    NSString* timeStr = [formatter stringFromDate:date];
    return [formatter stringFromDate:date];
}

///将指定时间格式的时间字符串转成date
+ (NSDate*)dateFromeTimeStr:(NSString*)timeStr with:(SSDateFormatterStyle)type {
    NSDateFormatter* formatter = [[SShelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
    return datestr;
}

///将指定时间格式的时间字符串转成时间戳
+ (NSString*)timeintervalStringFromeTimeString:(NSString*)timeStr with:(SSDateFormatterStyle)type {
    NSDateFormatter* formatter = [[SShelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datestr timeIntervalSince1970]];
    return timeSp;
}

///将指定时间格式的时间字符串转成NSTimeInterval
+ (NSTimeInterval)timeintervalFromeTimeString:(NSString*)timeStr with:(SSDateFormatterStyle)type {
    NSDateFormatter* formatter = [[SShelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datestr timeIntervalSince1970]*1000];
    return [datestr timeIntervalSince1970];
}
///获取当前时间的时间戳
+ (NSTimeInterval)getCurrentTimeInterval {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    //    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型;
    //    return [timeString doubleValue];
    return a;
}
///获取当前时间的时间戳字符串
+ (NSString*)getCurrentTimeIntervalStr {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString* timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型;
    return timeString;
    //    return [timeString doubleValue];
    //    return a;
}


#pragma mark ----------- Create View ----------------
///Label
+ (UILabel*)SSlabel:(UIFont*)font textAlignment:(NSTextAlignment)alignment textColor:(UIColor*)textColor backgroundColor:(UIColor*)bgcolor {
    UILabel* label = [UILabel new];
    label.backgroundColor = bgcolor ? bgcolor : [UIColor clearColor];
    label.textAlignment = alignment;
    label.font = font ? font : [UIFont systemFontOfSize:15];
    label.textColor = textColor ? textColor : [UIColor lightGrayColor];
    return label;
}

///创建线条
+ (UIView*)SSline:(UIColor* _Nullable)bgColor {
    UIView* line = [UIView new];
    line.backgroundColor = bgColor ? bgColor : [UIColor clearColor];
    return line;
}

///创建按钮（简单属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

///创建按钮（简单属性带有背景色）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    return button;
}

///创建按钮（简单属性带有背景图）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor font:(UIFont*)font bgImgStr:(NSString* _Nullable)imgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (imgStr) {
        [button setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    }
    return button;
}

///创建按钮（带有全面属性）
+ (UIButton*)SSbutton:(UIButtonType)type title:(NSString* _Nullable)title titleColor:(UIColor* _Nullable)titleColor selectedTitle:(NSString* _Nullable)selectTitle selectedColor:(UIColor* _Nullable)selectColor font:(UIFont*)font bgColor:(UIColor* _Nullable)bgColor bgImg:(NSString* _Nullable)bgimgStr {
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectColor) {
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = font;
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    if (bgimgStr) {
        [button setBackgroundImage:[UIImage imageNamed:bgimgStr] forState:UIControlStateNormal];
    }
    
    return button;
}

///创建UITextField
+ (UITextField*)SStextField:(NSString*)placeHolder andTextColor:(UIColor*)textColor andFont:(UIFont*)font {
    UITextField* textF = [[UITextField alloc] init];
    textF.placeholder = placeHolder;
    textF.textColor = textColor;
    textF.font = font;
    return textF;
}

///创建imageView
+ (UIImageView*)SSimgeView:(CGRect)frame imgName:(NSString* _Nullable)imgName {
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
    if (![SShelper isObjNil:imgName]) {
        imgView.image = [UIImage imageNamed:imgName];
    }
    imgView.backgroundColor = [UIColor clearColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    return imgView;
}

///生成二维码
+ (UIImage*)SSgetQRcodeWithStr:(NSString*)str size:(CGFloat)size {
    //创建过滤器
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage* image = [filter outputImage];
    UIImage* img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}
+ (UIImage*)createNonInterpolatedUIImageFromCIImage:(CIImage*)image WithSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

///截取指定视图的指定区域，传入需要截取的view
+ (UIImage*)SSscreenShot:(UIView*)view {
    UIImage* imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 1);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = [imageRet CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, imageRet.size.height - statusBarHeight - 44, imageRet.size.width, statusBarHeight+44));
    UIImage* newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
    //    return imageRet;
}


#pragma mark ------ 小功能 -------
/**
 判断对象是否为空，包括nil 空字符串、空字典、空数组等
 @param obj 对象
 @return 是否为空标识
 */
+ (BOOL)isObjNil:(id _Nullable )obj {
    if (!obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)obj;
        if (dictionary.allKeys.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        if (array.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if (![obj length] || obj == nil || obj == NULL || [obj isKindOfClass:[NSNull class]] || [[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [obj isEqualToString:@"(null)"] || [obj stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
            return YES;
        }
    }
    return NO;
}
///复制
+ (void)SScopyStr:(NSString*)str {
    if ([self isObjNil:str]) {
        return;
    }
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
//    [self presentMessageTips:@"复制成功！"];
}
///打电话
+ (void)SScallPhone:(NSString*)phoneNum {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNum]] options:@{} completionHandler:nil];
    } else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNum]]];
    }
}
///打开/跳转URL
+ (void)SSopenURL:(NSString*)urlStr {
    NSURL* url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
///状态栏字体颜色(0:白色: 非0:黑色)
+ (void)SSstatusBarTextColor:(int)intValue {
    if (intValue == 0) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}
/**
 图文混排
 @param str 文字
 @param color 文字颜色
 @param font 文字字号
 @param imageName 图片名
 @param isfront 图片是否在前面  YES:前面；NO：后面
 @param rect 图片的
 */
+ (NSMutableAttributedString*)SSattri:(NSString*)str Color:(UIColor*)color Font:(UIFont*)font andImageName:(NSString*)imageName isFront:(BOOL)isfront andRect:(CGRect)rect {
    NSMutableAttributedString* attri =  [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attri.length)];
    [attri addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attri.length)];
    
    NSTextAttachment* attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
//    attch.bounds = CGRectMake(0, -10, ssscale(36), ssscale(29));
    attch.bounds = rect;
    NSAttributedString* string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:isfront ? 0 : attri.length];
    return attri;
}

///数字从0开始跳动
+ (void)SSchangeNumDuration:(int)duration start:(CGFloat)startNum end:(CGFloat)endNum and:(CATextLayer*)textLayer {
    
}

///获取当前屏幕显示的viewcontroller
+ (UIViewController*)getCurrentVC {
    UIViewController* rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController* currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController*)getCurrentVCFrom:(UIViewController*)rootVC {
    UIViewController* currentVC;
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

///根据dic自动生成model属性
+ (void)SSautoPropertyWith:(NSDictionary*)dic {
    NSMutableString* proprety = [[NSMutableString alloc] init];
    //遍历数组 生成声明属性的代码，例如 @property (nonatomic, copy) NSString str
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str;
//        NSLog(@"---%@",[obj class]);
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")] || [obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            str = [NSString stringWithFormat:@"@property(nonatomic, strong) NSString *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            str = [NSString stringWithFormat:@"@property(nonatomic, assign) int %@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")] || [obj isKindOfClass:[NSArray class]]) {
            str = [NSString stringWithFormat:@"@property(nonatomic, strong) NSArray *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")] || [obj isKindOfClass:[NSDictionary class]]) {
            str = [NSString stringWithFormat:@"@property(nonatomic, strong) NSDictionary *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            str = [NSString stringWithFormat:@"@property(nonatomic, assign) BOOL %@;",key];
        }
        
        [proprety appendFormat:@"\n%@\n",str];
    }];
    NSLog(@"%@",proprety);
}

#pragma mark ----------  弹框或跳转界面 ------------
///AlertActionSheet
+ (void)SSshowActionSheet:(NSArray<UIAlertAction*>*)actions tips:(NSString*)tips message:(NSString*)message target:(UIViewController*)target {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:tips message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction* action in actions) {
        [alertController addAction:action];
    }
#pragma mark 解决弹出界面卡顿问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:alertController animated:YES completion:nil];
    });
}

///跳转到对应H5界面
+ (void)SSintoH5:(UIViewController*)viewController urlStr:(NSString*)urlStr {
    SSwebBaseVC* webVC = [[SSwebBaseVC alloc] init];
    webVC.urlString = urlStr;
    webVC.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:webVC animated:YES];
}

///进入搜索界面
+ (void)SSintoSearchVC:(UIViewController*)viewController {
    SSsearchBaseVC* search = [[SSsearchBaseVC alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:search animated:NO];
}

///全屏展示图片
+ (void)SSshowImages:(NSArray*)images index:(NSInteger)index currentVC:(UIViewController*)currentVC {
    if(images.count < 1) {
        return;
    }
//    NSMutableArray *photos = [NSMutableArray new];
//    if ([images.firstObject isKindOfClass:[UIImage class]]) {
//        for(UIImage* image in images){
//            GKPhoto *photo = [GKPhoto new];
//            photo.image = image;
//            [photos addObject:photo];
//        }
//    }else{
//        for(NSString* url in images){
//            GKPhoto *photo = [GKPhoto new];
//            photo.url = [NSURL URLWithString:url];
//            [photos addObject:photo];
//        }
//    }
//    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
//    browser.showStyle = GKPhotoBrowserShowStyleNone;
//    browser.hideStyle = GKPhotoBrowserShowStyleNone;
//    //    browser.isFullScreenDisabled = YES;
//    [browser showFromVC:currentVC];
}

///融云初始化/刷新指定用户数据
//+ (void)refreshRongCloud:(NSString*)uid and:(NSString*)name and:(NSString*)imageUrl {
//    RCUserInfo* userinfo = [[RCUserInfo alloc] initWithUserId:uid name:name portrait:imageUrl];
//    [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:uid];
//}


//+ (void)toSchemeUrl:(NSURL *)url {
//
//    NSDictionary *parameter = [NSString dictionaryWithUrlString:url.absoluteString];
//    UIViewController *vc = [self getCurrentVC];
//
//    if ([[url scheme] isEqualToString:yiqiScheme]) {    //本地服务
//        if (parameter[@"SSapp_action"]) {
//
//            if ([parameter[@"SSapp_action"] isEqualToString:@"share"]) {
//
//                SSshareDetailVC* shareDetail = [SSshareDetailVC new];
//                shareDetail.idString = [NSString stringWithFormat:@"%@",parameter[@"action_id"]];
//                shareDetail.hidesBottomBarWhenPushed = YES;
//                [vc.navigationController pushViewController:shareDetail animated:YES];
//            }else if ([parameter[@"SSapp_action"] isEqualToString:@"need"]){
//                SSneedDetailVC* needDetail = [SSneedDetailVC new];
//                needDetail.hidesBottomBarWhenPushed = YES;
//                needDetail.idStr = [NSString stringWithFormat:@"%@",parameter[@"action_id"]];
//                [vc.navigationController pushViewController:needDetail animated:YES];
//            }else if ([parameter[@"SSapp_action"] isEqualToString:@"release"]){
////                yiqibnb://test.yiqibnb.com?SSapp_action=release
//                SScenterViewVC* center = [SScenterViewVC new];
//                SSbaseNavigationC* navi = [[SSbaseNavigationC alloc] initWithRootViewController:center];
//                [vc.navigationController presentViewController:navi animated:true completion:^{
//                }];
//            }else if ([parameter[@"SSapp_action"] isEqualToString:@"address"]){
//                SSReceiptAddressListVC *addressVC = [[SSReceiptAddressListVC alloc] initWithReturnBlock:^(NSDictionary * _Nonnull model, SSReceiptAddressListVC * _Nonnull addressVC) {
//                    [addressVC dismissViewControllerAnimated:true completion:^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:appNoticeWebKey object:nil];
//                    }];
//                }];
//                SSbaseNavigationC* navi = [[SSbaseNavigationC alloc] initWithRootViewController:addressVC];
//                [vc.navigationController presentViewController:navi animated:true completion:nil];
//            }
//        }
//    }else if ([[url scheme] isEqualToString:httpsScheme]){  //https
//        [SShelper viewController:vc showWebViewControllerWithUrlString:url.absoluteString];
//    }else if ([[url scheme] isEqualToString:httpScheme]){   //http
//        [SShelper viewController:vc showWebViewControllerWithUrlString:url.absoluteString];
//    }
//
//}

#pragma mark ------------- 正则表达式判断 ---------------
///数字或26个英文字母组成的字符串
+ (BOOL)isNUmAndEnglishAlphahet:(NSString*_Nullable)str {
    if ([SShelper isObjNil:str]) {
        return NO;
    }
    NSString* numStr = @"^[A-Za-z0-9]+$";
    NSPredicate* numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numStr];
    return [numPredicate evaluateWithObject:str];
}
///纯英文字母
+ (BOOL)isEnglishAlphabet:(NSString*_Nullable)Str {
    if ([SShelper isObjNil:Str]) {
        return NO;
    }
    NSString* numStr = @"^[A-Za-z]+$";
    NSPredicate* numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numStr];
    return [numPredicate evaluateWithObject:Str];
}
///纯数字
+ (BOOL)isNum:(NSString*_Nullable)Str {
    if ([SShelper isObjNil:Str]) {
        return NO;
    }
    NSString* numStr = @"^[0-9]*$";
    NSPredicate* numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numStr];
    return [numPredicate evaluateWithObject:Str];
}
///身份证号YES：有效； NO：无效
+ (BOOL)isValidIdenditifyCard:(NSString*)cardStr {
    if ([SShelper isObjNil:cardStr]) {
        return NO;
    }
    NSString* regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate* identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardStr];
}
///邮箱YES：有效； NO：无效
+ (BOOL)isValidEmail:(NSString*)email {
    if ([SShelper isObjNil:email]) {
        return NO;
    }
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
///手机号码YES：有效； NO：无效
+ (BOOL)isValidPhoneeNumber:(NSString*)mobileNum {
    if ([SShelper isObjNil:mobileNum]) {
        return NO;
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString* MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString* CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString* CU = @"^1(3[0-2]|5[256]|6[0-9]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString* CT = @"^1((33|53|8[0-9]|9[9])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate* regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate* regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate* regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    }else{
        return NO;
    }
}
///金额格式YES：有效； NO：无效
+ (BOOL)isValidMoney:(NSString*)moneySr {
    //需求：
    ///位数可控（限定9位）
    ///小数点后两位
    ///开头最多输入一个0
    ///只能有一位小数点
    if ([SShelper isObjNil:moneySr]) {
        return NO;
    }else{
        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数
        NSPredicate* money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        return [money evaluateWithObject:moneySr];
    }
}
///银行卡号YES：有效； NO：无效
+ (BOOL)isValidBankCard:(NSString *)cardNumber {
    if ([SShelper isObjNil:cardNumber]) {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0, digit = 0, addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

#pragma mark ------------- 当前应用qpp信息 --------
///当前app名称
+ (NSString*)ss_appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
///当前app版本号（1.0.1）
+ (NSString*)ss_versionForApp {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark ------------- 当前设备信息 -------------
///系统版本号
+ (NSString*)ss_getVersion {
    return [[UIDevice currentDevice] systemVersion];
}
///设备型号
+ (NSString*)ss_getIphoneType {
    //需要导入头文件：#import <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    //    SSLog(@"----------- platform = %@",platform);
    ///iphone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    
    ///iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad (3rd generation)";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad (4th generation)";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro (9.7-inch)";
    
    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad (5th generation)";
    
    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro (12.9-inch, 2nd generation)";
    
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro (10.5-inch)";
    
    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad (6th generation)";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}
///获取设备号(udid)(已废除)
+ (NSString*)getDeviceNum {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
///获取设备唯一广告标识符
+ (NSString*)SSgetDeviceADstr {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}







NSString* SSformatDate(NSInteger timespace) {
    timespace = timespace /1000.0f;
    NSInteger current = [[NSDate date] timeIntervalSince1970];
    NSInteger gap = current - timespace;
    if(gap < 1){
        return @"刚刚";
    }else{
        if(gap < 60){
            return @"1分钟前";
        }else if(gap >= 60 && gap < 3600){
            return [NSString stringWithFormat:@"%ld分钟前",gap/60];
        }else if(gap >= 3600 && gap < 3600*24){
            return [NSString stringWithFormat:@"%ld小时前",gap/3600];
        }else if(gap >= 3600*24 && gap < 3600*24*2 ){
            return  @"昨天";
        }else if(gap >= 3600*24*2 && gap < 3600*24*3 ){
            return  @"前天";
        }else{
            return [SShelper stringFromeTimeInterval:[NSString stringWithFormat:@"%ld",(long)timespace] with:(SSDateFormatterStyle_4)];
            //            return [[NSDate dateWithTimeIntervalSince1970:timespace] toString:DATE_FORMATTER];
        }
    }
}
///金额格式
NSString* SSformatMoney(id money) {
    double price = [money doubleValue];
    return [NSString stringWithFormat:@"%.2f",price];
}



@end
