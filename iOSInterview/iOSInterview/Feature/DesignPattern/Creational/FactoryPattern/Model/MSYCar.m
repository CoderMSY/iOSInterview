//
//  MSYCar.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYCar.h"

@implementation MSYCar

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)drive {
    NSLog(@"%s", __func__);
}

@end
