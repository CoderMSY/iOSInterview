//
//  MSYInstanceAdapter.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import "MSYInstanceAdapter.h"

@interface MSYInstanceAdapter ()

@property (nonatomic, strong) id<MSYTypeCProtocol> typeC;

@end

@implementation MSYInstanceAdapter

#pragma mark - lifecycle methods

- (instancetype)initWithTypeC:(id<MSYTypeCProtocol>)typeC {
    self = [super init];
    if (self) {
        self.typeC = typeC;
    }
    return self;
}

#pragma mark - MSYMicroUSBProtocol

- (void)microUSB {
    [self.typeC typeC];
}

@end
