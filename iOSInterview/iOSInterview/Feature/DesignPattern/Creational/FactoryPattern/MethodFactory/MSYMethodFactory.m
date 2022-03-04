//
//  MSYMethodFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYMethodFactory.h"

@implementation MSYMethodFactory

#pragma mark - lifecycle methods

+ (instancetype)methodFactory {
    MSYMethodFactory *factory = [[MSYMethodFactory alloc] init];
    
    return factory;
}

#pragma mark - public methods

- (MSYCar *)createSportCar {
    MSYCar *car = [[MSYCar alloc] initWithName:@"unknow car"];
    
    return car;
}

- (MSYCar *)createBusinessCar {
    MSYCar *car = [[MSYCar alloc] initWithName:@"unknow car"];
    
    return car;
}

#pragma mark - private methods

#pragma mark - getter && setter

@end
