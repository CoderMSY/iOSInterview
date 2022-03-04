//
//  MSYAudiFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYAudiFactory.h"
#import "MSYAudiSportCar.h"
#import "MSYAudiBusinessCar.h"

@implementation MSYAudiFactory

+ (instancetype)methodFactory {
    MSYAudiFactory *factory = [[MSYAudiFactory alloc] init];
    
    return factory;
}

- (MSYCar *)createSportCar {
    MSYAudiSportCar *car = [[MSYAudiSportCar alloc] initWithName:@"Audi Sport Car"];
    
    return car;
}

- (MSYCar *)createBusinessCar {
    MSYAudiBusinessCar *car = [[MSYAudiBusinessCar alloc] initWithName:@"Audi Business Car"];
    
    return car;
}

@end
