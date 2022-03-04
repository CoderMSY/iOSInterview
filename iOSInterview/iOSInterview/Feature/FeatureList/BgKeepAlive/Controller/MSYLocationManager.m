//
//  MSYLocationManager.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import "MSYLocationManager.h"

@interface MSYLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
/// 定位成功的回调block
@property (nonatomic, copy) void (^successBlock)(NSArray<CLLocation *> *locations);
/// 编码成功的回调block
@property (nonatomic, copy) void (^geocoderBlock)(NSArray<CLPlacemark *> * _Nullable placemarks);
/// 定位失败的回调block
@property (nonatomic, copy) void (^failureBlock)(NSError *error);
@end

@implementation MSYLocationManager

+ (instancetype)shareInstance {
    static MSYLocationManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.locationManager = [[CLLocationManager alloc] init];
        instance.locationManager.delegate = instance;
//        [instance.locationManager requestWhenInUseAuthorization];
//        [instance.locationManager requestAlwaysAuthorization]
    });
    return instance;
}

- (void)setLocationType:(MSYLocationType)locationType {
    _locationType = locationType;
    switch (locationType) {
        case MSYLocationType_whenInUseAuth:
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case MSYLocationType_always:
            [self.locationManager requestAlwaysAuthorization];
            // 后台定位依然可用
            self.locationManager.allowsBackgroundLocationUpdates = YES;
            break;
            
        default:
            break;
    }
}

- (BOOL)isCanUseLocation {
    if (([CLLocationManager locationServicesEnabled]
         && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    }
    return NO;
}

- (void)startLocation {
    [self startLocationWithSuccessBlock:nil failureBlock:nil geocoderBlock:nil];
}

- (void)startLocationWithSuccessBlock:(void (^)(NSArray<CLLocation *> *))successBlock
                         failureBlock:(void (^)(NSError *))failureBlock {
    [self startLocationWithSuccessBlock:successBlock failureBlock:failureBlock geocoderBlock:nil];
}

- (void)startLocationWithGeocoderBlock:(void (^)(NSArray<CLPlacemark *> * _Nullable))geocoderBlock {
    [self startLocationWithSuccessBlock:nil failureBlock:nil geocoderBlock:geocoderBlock];
}

- (void)startLocationWithGeocoderBlock:(void (^)(NSArray<CLPlacemark *> * _Nullable))geocoderBlock
                          failureBlock:(void (^)(NSError *))failureBlock {
    [self startLocationWithSuccessBlock:nil failureBlock:failureBlock geocoderBlock:geocoderBlock];
}

- (void)startLocationWithSuccessBlock:(void (^)(NSArray<CLLocation *> *))successBlock
                         failureBlock:(void (^)(NSError *))failureBlock
                        geocoderBlock:(void (^)(NSArray<CLPlacemark *> * _Nullable))geocoderBlock {
    [self.locationManager startUpdatingLocation];
    _successBlock = successBlock;
    _geocoderBlock = geocoderBlock;
    _failureBlock = failureBlock;
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

/// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (self.locationType != MSYLocationType_always) {
        [manager stopUpdatingLocation];
    }
    
    if (_successBlock) {
        _successBlock(locations);
    }
    
    if (_geocoderBlock && locations.count) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:[locations firstObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                if (self->_failureBlock) {
                    self->_failureBlock(error);
                }
            } else {
                self->_geocoderBlock(placemarks);
            }
        }];
    }
}

/// 定位失败回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"LocationManager定位失败, 错误: %@",error);
    switch([error code]) {
        case kCLErrorDenied: { // 用户禁止了定位权限
            
        } break;
        default: break;
    }
    if (_failureBlock) {
        _failureBlock(error);
    }
}

@end
