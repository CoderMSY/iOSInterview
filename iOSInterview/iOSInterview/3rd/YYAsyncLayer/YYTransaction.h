//
//  YYTransaction.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/4/18.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//
/*
 YYTransaction绘制任务的机制是仿照CoreAnimation的绘制机制，监听主线程RunLoop，在空闲阶段插入绘制任务，并将任务优先级设置在CoreAnimation绘制完成之后，然后遍历绘制任务集合进行绘制工作并且清空集合，具体可以看源码。
 作者：繁星mind
 链接：https://www.jianshu.com/p/e3a1bede3116
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 YYTransaction let you perform a selector once before current runloop sleep.
 */
@interface YYTransaction : NSObject

/**
 Creates and returns a transaction with a specified target and selector.
 根据传入的target和selector来创建一个任务。
 @param target    A specified target, the target is retained until runloop end.
 @param selector  A selector for target.
 
 @return A new transaction, or nil if an error occurs.
 */
+ (YYTransaction *)transactionWithTarget:(id)target selector:(SEL)selector;

/**
 Commit the trancaction to main runloop.
 它用来在runloop睡眠的时候，执行传入任务，并且对于相同的任务，在runloop中只执行一次
 @discussion It will perform the selector on the target once before main runloop's
 current loop sleep. If the same transaction (same target and same selector) has 
 already commit to runloop in this loop, this method do nothing.
 */
- (void)commit;

@end

NS_ASSUME_NONNULL_END
