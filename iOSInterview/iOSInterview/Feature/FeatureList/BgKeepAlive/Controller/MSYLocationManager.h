//
//  MSYLocationManager.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYLocationType) {
    MSYLocationType_whenInUseAuth,
    MSYLocationType_always,
//    <#MyEnumValueC#>,
};

@interface MSYLocationManager : NSObject

@property (nonatomic, assign) MSYLocationType locationType;
+ (instancetype)shareInstance;

/// 是否开启定位
- (BOOL)isCanUseLocation;

/// 开始定位
- (void)startLocation;
- (void)startLocationWithSuccessBlock:(void (^_Nullable)(NSArray<CLLocation *> *locations))successBlock
                         failureBlock:(void (^_Nullable)(NSError *error))failureBlock;
- (void)startLocationWithGeocoderBlock:(void (^_Nullable)(NSArray<CLPlacemark *> * _Nullable placemarks))geocoderBlock;
- (void)startLocationWithGeocoderBlock:(void (^_Nullable)(NSArray<CLPlacemark *> * _Nullable placemarks))geocoderBlock
                          failureBlock:(void (^_Nullable)(NSError *error))failureBlock;
- (void)startLocationWithSuccessBlock:(void (^_Nullable)(NSArray<CLLocation *> *locations))successBlock
                         failureBlock:(void (^_Nullable)(NSError *error))failureBlock
                        geocoderBlock:(void (^_Nullable)(NSArray<CLPlacemark *> * _Nullable placemarks))geocoderBlock;
/// 结束定位
- (void)stopUpdatingLocation;

@end

NS_ASSUME_NONNULL_END
