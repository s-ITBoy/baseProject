//
//  SSpaoMaDengV.h
//  ddz
//
//  Created by F S on 2019/12/31.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSpaoMaDengV;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SSpaoMaDengVDirection) {
    SSpaoMaDengVDirectionUpward,   // scroll from bottom to top
    SSpaoMaDengVDirectionLeftward  // scroll from right to left
};

#pragma mark - SSpaoMaDengVDelegate
@protocol SSpaoMaDengVDelegate <NSObject>
- (NSUInteger)numberOfDataForMarqueeView:(SSpaoMaDengV*)marqueeView;
- (void)createItemView:(UIView*)itemView forMarqueeView:(SSpaoMaDengV*)marqueeView;
- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(SSpaoMaDengV*)marqueeView;
@optional
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(SSpaoMaDengV*)marqueeView;   // only for [SSpaoMaDengVDirectionUpward]
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(SSpaoMaDengV*)marqueeView;   // only for [SSpaoMaDengVDirectionLeftward]
- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(SSpaoMaDengV*)marqueeView;
@end

@interface SSpaoMaDengV : UIView

@property (nonatomic, weak) id<SSpaoMaDengVDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval timeIntervalPerScroll;
@property (nonatomic, assign) NSTimeInterval timeDurationPerScroll; // only for [SSpaoMaDengVDirectionUpward]
@property (nonatomic, assign) float scrollSpeed;    // only for [SSpaoMaDengVDirectionLeftward]
@property (nonatomic, assign) float itemSpacing;    // only for [SSpaoMaDengVDirectionLeftward]
@property (nonatomic, assign) BOOL clipsToBounds;
@property (nonatomic, assign, getter=isTouchEnabled) BOOL touchEnabled;
@property (nonatomic, assign) SSpaoMaDengVDirection direction;
- (instancetype)initWithDirection:(SSpaoMaDengVDirection)direction;
- (instancetype)initWithFrame:(CGRect)frame direction:(SSpaoMaDengVDirection)direction;
///拿到数据后需要调用此方法
- (void)reloadData;
- (void)start;
- (void)pause;

@end

#pragma mark - SSpaoMaDengVTouchResponder(Private)
@protocol SSpaoMaDengVTouchResponder <NSObject>
- (void)touchAtPoint:(CGPoint)point;
@end

#pragma mark - SSpaoMaDengVTouchReceiver(Private)
@interface SSpaoMaDengVTouchReceiver : UIView
@property (nonatomic, weak) id<SSpaoMaDengVTouchResponder> touchDelegate;
@end

NS_ASSUME_NONNULL_END
