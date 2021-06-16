//
//  SSmarqueeV.h
//  baseProject
//
//  Created by F S on 2017/12/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSmarqueeV;

typedef NS_ENUM(NSUInteger, SSmarqueeDirection) {
    SSmarqueeDirectionToUp,
    SSmarqueeDirectionToDown,
    SSmarqueeDirectionToLeft,
    SSmarqueeDirectionToRight
};

NS_ASSUME_NONNULL_BEGIN

@protocol SSmarqueeDelegate <NSObject>
- (NSInteger)SSnumberOfDataForMarquee:(SSmarqueeV*)marquee;
///此方法的优先级低于下面的SScreateView方法
- (UIView*)SScreateItemView:(UIView*)itemV index:(NSUInteger)index forMarquee:(SSmarqueeV*)marquee;
- (void)SSupdateItemView:(UIView*)itemV index:(NSUInteger)index forMarquee:(SSmarqueeV*)marquee;
@optional

///此方法的优先级高于上面的SScreateItemView方法，且需要手动将创建的view加入到itemV中，并需要设置frame=itemV.bounds，当实现了此方法则上面的SScreateItemView方法无效
- (void)SScreateView:(UIView*)itemV index:(NSUInteger)index forMarquee:(SSmarqueeV*)marquee;
///此方法仅对 上下方向（当设置返回值<=0时，则默认返回1）
- (NSInteger)SSnumberOfShowItemForMarquee:(SSmarqueeV*)marquee;
///此方法仅对 左右方向，此值不能小于marquee.bounds.size.width,因为是取两者中的最大值
- (CGFloat)SSitemWidthAt:(NSUInteger)index forMarquee:(SSmarqueeV*)marquee;
///点击了item的方法
- (void)SSdidTouchItemAt:(NSUInteger)index forMarquee:(SSmarqueeV*)marquee;

@end

///跑马灯视图view(支持四个方向)
@interface SSmarqueeV : UIView
@property(nonatomic,weak) id<SSmarqueeDelegate> delegate;
///计时器 时间间隔 默认 2.0s
@property(nonatomic,assign) CGFloat timeIntervalForTimer;
///滚动时间的时间长度 默认 1.0s
@property(nonatomic,assign) CGFloat durationForScroll;
///计时器是否开始
@property(nonatomic,assign,readonly) BOOL isStartTimer;

- (instancetype)initWithDirection:(SSmarqueeDirection)direction;
- (instancetype)initWithFrame:(CGRect)frame direction:(SSmarqueeDirection)direction;


#pragma mark ----------- 方式一 计时器使用的是ios 10 以前的方法， 当添加SSmarqueeV的view 或 VC 消失释放时，需在其对应的 dealloc 方法中调用SSpause -------------
///拿到数据后 需调用此方法，类似于tableView的reloadData 否则无法显示数据
- (void)SSreloadData;
- (void)SSstart;
- (void)SSpause;

#pragma mark ------------ 方式二 计时器使用的是ios 10 以前的方法，将计时器封装到 NSobject 的管理类中以方便使用 --------------
///拿到数据后 需调用此方法，类似于tableView的reloadData 否则无法显示数据
- (void)SSreloadDataByDelegate;
- (void)SSstartByDelegate;
- (void)SSpauseByDelegate;

#pragma mark ------------ 方式三 计时器使用的是 ios 10 及以后才有的方法 -------------
///拿到数据后 需调用此方法，类似于tableView的reloadData 否则无法显示数据
- (void)SSreloadData_ios_10;
- (void)SSstart_ios_10;
- (void)SSpause_ios_10;

@end

//@interface SStimerManager : NSObject
//
////- (void)SSstartTimer;
////- (void)SSendTimer;
//@end

NS_ASSUME_NONNULL_END
