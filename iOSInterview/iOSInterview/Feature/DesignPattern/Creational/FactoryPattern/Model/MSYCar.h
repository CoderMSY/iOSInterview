//
//  MSYCar.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYCar : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (void)drive;

@end

NS_ASSUME_NONNULL_END
