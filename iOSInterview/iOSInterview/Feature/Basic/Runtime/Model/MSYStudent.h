//
//  MSYStudent.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/16.
//

#import "MSYPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYStudent : MSYPerson

- (void)msy_studentInstanceMethod;

- (void)msy_studentInstanceMethodIsImpl;

+ (void)msy_studentClassMethod;

+ (void)msy_studentClassMethodIsImpl;

@end

NS_ASSUME_NONNULL_END
