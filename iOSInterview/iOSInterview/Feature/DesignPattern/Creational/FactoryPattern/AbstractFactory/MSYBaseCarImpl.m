//
//  MSYBaseCarImpl.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYBaseCarImpl.h"

@implementation MSYBaseCarImpl

#pragma mark - public methods

- (MSYCar *)createSportCar {
    MSYCar *car = [[MSYCar alloc] initWithName:@"unknow car"];
    
    return car;
}

- (MSYCar *)createBusinessCar {
    MSYCar *car = [[MSYCar alloc] initWithName:@"unknow car"];
    
    return car;
}

@end
