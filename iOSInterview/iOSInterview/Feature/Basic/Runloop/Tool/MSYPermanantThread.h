//
//  MSYPermanantThread.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MSYPermanantThreadTask)(void);

@interface MSYPermanantThread : NSObject

- (void)executeTask:(MSYPermanantThreadTask)task;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
