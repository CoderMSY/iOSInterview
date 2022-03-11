//
//  MSYGCDDefine.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#ifndef MSYGCDDefine_h
#define MSYGCDDefine_h

static NSString *const kGCDTitle_syncConcurrent = @"同步执行+并发队列";
static NSString *const kGCDTitle_asyncConcurrent = @"异步执行 + 并发队列";
static NSString *const kGCDTitle_syncSerial = @"同步执行 + 串行队列";
static NSString *const kGCDTitle_asyncSerial = @"异步执行 + 串行队列";
static NSString *const kGCDTitle_syncMain = @"同步执行 + 主队列:主线程产生死锁";
static NSString *const kGCDTitle_asyncMain = @"异步执行 + 主队列";

static NSString *const kGCDTitle_communication = @"GCD 线程间的通信";

static NSString *const kGCDTitle_barrier_async = @"GCD 栅栏方法：dispatch_barrier_async";
static NSString *const kGCDTitle_after = @"GCD 延时执行方法：dispatch_after";
static NSString *const kGCDTitle_once = @"GCD 一次性代码（只执行一次）：dispatch_once";
static NSString *const kGCDTitle_apply = @"GCD 快速迭代方法：dispatch_apply";
static NSString *const kGCDTitle_group_notify = @"GCD 队列组：dispatch_group_notify";
static NSString *const kGCDTitle_group_wait = @"GCD 队列组：dispatch_group_wait";
static NSString *const kGCDTitle_groupEnterAndLeave = @"dispatch_group_enter、dispatch_group_leave";
static NSString *const kGCDTitle_semaphoreSync = @"GCD 信号量：dispatch_semaphore";
static NSString *const kGCDTitle_ticketStatusSave = @"线程安全（使用 semaphore 加锁）- 售票案例";

#endif /* MSYGCDDefine_h */
