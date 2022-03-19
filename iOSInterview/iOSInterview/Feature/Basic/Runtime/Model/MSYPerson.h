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
- (void)personInstanceMethod;
///子类父类都未实现
- (void)personInstanceMethodIsNotImpl;

+ (void)personClassMethod;
///子类父类都未实现
+ (void)personClassMethodIsNotImpl;


- (void)unrecognizedMethod;

@end

NS_ASSUME_NONNULL_END
