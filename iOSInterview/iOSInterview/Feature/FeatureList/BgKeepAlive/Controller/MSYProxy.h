//
//  MSYProxy.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYProxy : NSObject

@property (weak, nonatomic) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
