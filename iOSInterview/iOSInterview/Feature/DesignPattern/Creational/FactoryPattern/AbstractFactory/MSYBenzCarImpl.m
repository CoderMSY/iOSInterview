//
//  MSYBenzCarImpl.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYBenzCarImpl.h"
#import "MSYBenzSportCar.h"
#import "MSYBenzBusinessCar.h"

@implementation MSYBenzCarImpl

- (MSYCar *)createSportCar {
    MSYBenzSportCar *car = [[MSYBenzSportCar alloc] initWithName:@"benz sport car"];
    
    return car;
}

- (MSYCar *)createBusinessCar {
    MSYBenzBusinessCar *car = [[MSYBenzBusinessCar alloc] initWithName:@"Benz Business Car"];
    
    return car;
}

@end
