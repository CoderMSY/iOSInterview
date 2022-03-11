//
//  NSObject+MSYJson.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MSYJson)

+ (instancetype)msy_objectWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
