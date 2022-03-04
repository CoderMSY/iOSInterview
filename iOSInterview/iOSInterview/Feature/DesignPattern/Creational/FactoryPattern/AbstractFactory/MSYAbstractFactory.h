//
//  MSYAbstractFactory.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import "MSYBenzCarImpl.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYAbstractFactoryType) {
    MSYAbstractFactoryType_unknow,
    MSYAbstractFactoryType_benz,
    MSYAbstractFactoryType_bwm,
    MSYAbstractFactoryType_audi,
};

@interface MSYAbstractFactory : NSObject

- (MSYBenzCarImpl *)getCarImplWithType:(MSYAbstractFactoryType)type;

@end

NS_ASSUME_NONNULL_END
