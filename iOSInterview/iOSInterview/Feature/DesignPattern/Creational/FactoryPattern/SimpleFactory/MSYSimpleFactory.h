//
//  MSYSimpleFactory.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import "MSYCar.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYCarType) {
    MSYCarType_unknow,
    MSYCarType_benzSport,
    MSYCarType_benzBusiness,
    MSYCarType_bmwSport,
    MSYCarType_bmwBusiness,
    MSYCarType_audiSport,
    MSYCarType_audiBusiness,
};

@interface MSYSimpleFactory : NSObject

+ (instancetype)simpleFactory;

- (MSYCar *)createCarWithType:(MSYCarType)carType;

@end

NS_ASSUME_NONNULL_END
