//
//  MSYAbstractFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYAbstractFactory.h"
#import "MSYBenzCarImpl.h"
#import "MSYBmwCarImpl.h"
#import "MSYAudiCarImpl.h"

@implementation MSYAbstractFactory

- (MSYBenzCarImpl *)getCarImplWithType:(MSYAbstractFactoryType)type {
    MSYBaseCarImpl *carImpl;
    switch (type) {
        case MSYAbstractFactoryType_benz:
            carImpl = [[MSYBenzCarImpl alloc] init];
            break;
        case MSYAbstractFactoryType_bwm:
            carImpl = [[MSYBmwCarImpl alloc] init];
            break;
        case MSYAbstractFactoryType_audi:
            carImpl = [[MSYAudiCarImpl alloc] init];
            break;
            
        default:
            carImpl = [[MSYBaseCarImpl alloc] init];
            break;
    }
    
    return carImpl;
}

@end
