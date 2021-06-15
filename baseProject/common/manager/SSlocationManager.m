//
//  SSlocationManager.m
//  baseProject
//
//  Created by F S on 2018/12/21.
//  Copyright © 2018 FL S. All rights reserved.
//

#import "SSlocationManager.h"

#define BaiDuMap_key  @"25UFnHixFZfGQI9zgrMlwIKFOLVWr8g1"

@interface SSlocationManager ()
///<BMKLocationManagerDelegate,BMKLocationAuthDelegate>
//@property (strong,nonatomic) BMKLocationManager* locationManager;
/////用于存入多个block
//@property(nonatomic,strong)NSMutableArray <void (^)(CLLocation* location, BMKLocationReGeocode* locationReGeoCode)>*blockArr;

@end
@implementation SSlocationManager
#pragma mark -------- 懒加载 ----------
//- (NSMutableArray<void (^)(CLLocation *, BMKLocationReGeocode *)> *)blockArr {
//    if (!_blockArr) {
//        _blockArr = [NSMutableArray arrayWithCapacity:1];
//    }
//    return _blockArr;
//}


+ (instancetype)shareManager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)SSinitWithAK {
//    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BaiDuMap_key authDelegate:self];
}

- (void)SSconfiguration {
//    //初始化实例
//    _locationManager = [[BMKLocationManager alloc] init];
//    //设置delegate
//    _locationManager.delegate = self;
//    //设置返回位置的坐标系类型
//    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
//    //设置距离过滤参数
//    _locationManager.distanceFilter = 10.0f;
//    //设置预期精度参数
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    //设置应用位置类型
//        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
//    //设置是否自动停止位置更新
//    _locationManager.pausesLocationUpdatesAutomatically = NO;
//    //设置是否允许后台定位
//    _locationManager.allowsBackgroundLocationUpdates = NO;
//    //设置位置获取超时时间
//    _locationManager.locationTimeout = 10;
//    //设置获取地址信息超时时间
//    _locationManager.reGeocodeTimeout = 10;
}
//
//- (void)SSlocationSuccessBlock:(void (^) (CLLocation* _Nullable location, BMKLocationReGeocode* _Nullable locationReGeoCode)) locationBlock {
//    if ([CLLocationManager locationServicesEnabled]) {
//        [self.blockArr addObject:locationBlock];
//        [self startLocation];
//    }
//}
//
//- (void)startLocation{
//   [self.locationManager setPausesLocationUpdatesAutomatically:YES];
//   [self.locationManager startUpdatingLocation];
//}
//
//- (void)stopLocation{
//   [self.locationManager stopUpdatingLocation];
//}
//
//#pragma mark --------- BMKLocationAuthDelegate -------------
//- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
//    switch (iError) {
//        case -1:
//            SSLog(@"------ 未知错误");
//            break;
//        case 0:
//            SSLog(@"------ 鉴权成功");
//            break;
//        case 1:
//            SSLog(@"------ 因网络导致错误");
//            break;
//        case 2:
//            SSLog(@"------ KEY非法导致错误");
//            break;
//
//        default:
//            break;
//    }
//}

//#pragma mark -------- BMKLocationManagerDelegate ---------
//- (void)BMKLocationManager:(BMKLocationManager *)manager didFailWithError:(NSError *)error {
//    [self startLocation];
//}
//
//- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
//    if (error){
//        SSLog(@"------定位失败-------:{%ld - %@};", (long)error.code, error.localizedDescription);
////        for (void(^block)(CLLocation* location, BMKLocationReGeocode* locationReGeoCode) in self.blockArr) {
////            NSLog(@"回调block = %@",block);
////            block(location.location,location.rgcData);
////        }
//        [self.blockArr enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(CLLocation *, BMKLocationReGeocode *), NSUInteger idx, BOOL * _Nonnull stop) {
//            obj(nil,nil);
//        }];
//    }
//    if (location) {
//        SSLog(@"------  %@",location.rgcData.province);
////        for (void(^block)(CLLocation* location, BMKLocationReGeocode* locationReGeoCode) in self.blockArr) {
////            SSLog(@"回调block = %@",block);
////            block(location.location,location.rgcData);
////
////        }
//        [self.blockArr enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(CLLocation *, BMKLocationReGeocode *), NSUInteger idx, BOOL * _Nonnull stop) {
//            obj(location.location, location.rgcData);
//        }];
//        [self.blockArr removeAllObjects];
//        
//        if ([self.delegate respondsToSelector:@selector(SSlocationSucc:and:)]) {
//            [self.delegate SSlocationSucc:location.location and:location.rgcData];
//        }
//        
//        [self stopLocation];
//    }
//}

- (void)parseArray:(NSArray*)addressArr and:(NSString*)areaStr{
    for (NSDictionary* province in addressArr) {
        for (NSDictionary* city in province[@"s"]) {
            for (NSDictionary* area in city[@"s"]) {
                if ([area[@"n"] isEqualToString:areaStr]) {
//                    _province_id = [province[@"v"] stringValue];
//                    _city_id = [city[@"v"] stringValue];
//                    _area_id = [area[@"v"] stringValue];
//                    NSLog(@"----- %@ ---- %@ ------- %@",_province_id,_city_id,_area_id);
                }
            }
        }
    }
}
@end

@interface SSmapManager ()
@end
@implementation SSmapManager

+ (instancetype)shareManager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (void)SSinitWithMapManager {
//    BMKMapManager* manager = [[BMKMapManager alloc] init];
//    BOOL ret = [manager start:BaiDuMap_key generalDelegate:nil];
//    if (ret) {
//        SSLog(@"------- 启动百度引擎唱功");
//    }else {
//        SSLog(@"------- 启动百度引擎失败");
//    }
}

@end
