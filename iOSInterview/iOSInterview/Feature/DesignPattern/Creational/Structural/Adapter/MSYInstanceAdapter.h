//
//  MSYInstanceAdapter.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import "MSYMicroUSBProtocol.h"
#import "MSYTypeCProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYInstanceAdapter : NSObject <MSYMicroUSBProtocol>

- (instancetype)initWithTypeC:(id<MSYTypeCProtocol>)typeC;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
