//
//  MSYCFPermanantThread.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MJCFPermenantThreadTask)(void);

@interface MSYCFPermanantThread : NSObject

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(MJCFPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
