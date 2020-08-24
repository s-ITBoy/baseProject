//
//  UIScrollView+SScategory.h
//  leeMail
//
//  Created by F S on 2017/7/10.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SScategory)

- (void)SS_endRefresh;
- (void)SS_addRefreshHeaderWithBlock:(void (^)(void))reFreshBlock;
- (void)SS_addRefreshFooterWithBlock:(void (^)(void))reFreshBlock;
- (void)SS_beginRefreshing;
- (void)SS_footerBeginRefresh;
- (BOOL)SS_headerIsRefreshing;

@end

NS_ASSUME_NONNULL_END
