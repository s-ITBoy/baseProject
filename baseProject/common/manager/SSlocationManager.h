//
//  SSlocationManager.h
//  baseProject
//
//  Created by F S on 2020/12/21.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <BMKLocationKit/BMKLocationComponent.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SSlocationManagerDelegate <NSObject>
///方式er 获取定位信息
//- (void)SSlocationSucc:(CLLocation*)location and:(BMKLocationReGeocode*)locationReGeoCode;

@end

@interface SSlocationManager : NSObject
///方式er 获取定位信息
@property(nonatomic,weak) id <SSlocationManagerDelegate> delegate;
+ (instancetype)shareManager;
- (void)SSinitWithAK;
- (void)SSconfiguration;
///方式一 获取定位信息
//- (void)SSlocationSuccessBlock:(void (^) (CLLocation* _Nullable location, BMKLocationReGeocode* _Nullable locationReGeoCode)) locationBlock;
@end

@interface SSmapManager : NSObject

+ (instancetype)shareManager;
- (void)SSinitWithMapManager;

@end

NS_ASSUME_NONNULL_END
