//
//  MSYPerson.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYPerson : NSObject

@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSNumber *age;
@property (copy, nonatomic) NSString *name;

- (void)run;
- (void)test;

@end

NS_ASSUME_NONNULL_END
