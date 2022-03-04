//
//  MSYSimpleFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYSimpleFactory.h"
#import "MSYBenzSportCar.h"
#import "MSYBenzBusinessCar.h"
#import "MSYBmwSportCar.h"
#import "MSYBmwBusinessCar.h"
#import "MSYAudiSportCar.h"
#import "MSYAudiBusinessCar.h"

@implementation MSYSimpleFactory

#pragma mark - lifecycle methods

+ (instancetype)simpleFactory {
    MSYSimpleFactory *factory = [[MSYSimpleFactory alloc] init];
    
    return factory;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - public methods

- (MSYCar *)createCarWithType:(MSYCarType)carType {
    MSYCar *car;
    switch (carType) {
        case MSYCarType_benzSport:
            car = [[MSYBenzSportCar alloc] initWithName:@"benz sport car"];
            break;
        case MSYCarType_benzBusiness:
            car = [[MSYBenzBusinessCar alloc] initWithName:@"benz business car"];
            break;
        case MSYCarType_bmwSport:
            car = [[MSYBmwSportCar alloc] initWithName:@"bmw sport car"];
            break;
        case MSYCarType_bmwBusiness:
            car = [[MSYBmwBusinessCar alloc] initWithName:@"bmw business car"];
            break;
        case MSYCarType_audiSport:
            car = [[MSYAudiSportCar alloc] initWithName:@"audi sport car"];
            break;
        case MSYCarType_audiBusiness:
            car = [[MSYAudiBusinessCar alloc] initWithName:@"audi business car"];
            break;
            
        default:
            car = [[MSYCar alloc] initWithName:@"unkonw car"];
            break;
    }
    
    return car;
}

#pragma mark - private methods

#pragma mark - getter && setter

@end
