//
//  UIScrollView+SS.h
//  leeMail
//
//  Created by F S on 2017/7/10.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSrefreshType) {
    ///默认样式
    SSrefreshTypeDefault   = 0,
    ///自定义样式
    SSrefreshTypecustom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SS)

- (void)SS_addRefreshHeaderWithBlock:(void (^)(void))reFreshBlock;
- (void)SS_addRefreshFooterWithBlock:(void (^)(void))reFreshBlock;
- (void)SS_beginRefreshing;
- (void)SS_endRefresh;
- (BOOL)SS_headerIsRefreshing;
- (void)SS_footerBeginRefresh;

#pragma mark -------- 以待后效 便于扩展 -----------

- (void)SS_addRefresh:(SSrefreshType)type HeaderWithBlock:(void(^)(void))reFreshBlock;
- (void)SS_addRefresh:(SSrefreshType)type FooterWithBlock:(void(^)(void))reFreshBlock;

@end

NS_ASSUME_NONNULL_END
