//
//  MSYMethodFactory.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import "MSYCar.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYMethodFactory : NSObject

+ (instancetype)methodFactory;

- (MSYCar *)createSportCar;
- (MSYCar *)createBusinessCar;

@end

NS_ASSUME_NONNULL_END
