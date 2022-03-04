//
//  MSYBmwFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYBmwFactory.h"
#import "MSYBmwSportCar.h"
#import "MSYBmwBusinessCar.h"

@implementation MSYBmwFactory

+ (instancetype)methodFactory {
    MSYBmwFactory *factory = [[MSYBmwFactory alloc] init];
    
    return factory;
}

- (MSYCar *)createSportCar {
    MSYBmwSportCar *car = [[MSYBmwSportCar alloc] initWithName:@"Bmw Sport Car"];
    
    return car;
}

- (MSYCar *)createBusinessCar {
    MSYBmwBusinessCar *car = [[MSYBmwBusinessCar alloc] initWithName:@"Bmw Business Car"];
    
    return car;
}

@end
