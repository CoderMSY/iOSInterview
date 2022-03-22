//
//  MSYLagMonitor.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/21.
//  参考：https://time.geekbang.org/column/article/89494

#import "MSYLagMonitor.h"

@interface MSYLagMonitor ()
{
    int _timeoutCount;  //超时次数
    CFRunLoopObserverRef _runLoopObserver; //观察者
@public
    dispatch_semaphore_t _semaphore;       //信号量
    CFRunLoopActivity _runLoopActivity;    //主线程runloop状态
}
@end

@implementation MSYLagMonitor

static void MSYRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    MSYLagMonitor *lagMonitor = [MSYLagMonitor shareInstance]; //(__bridge MSYLagMonitor *)(info);
    lagMonitor->_runLoopActivity = activity;
    
    dispatch_semaphore_t semaphore = lagMonitor->_semaphore;
    dispatch_semaphore_signal(semaphore);
}

#pragma mark - lifecycle methods

+ (instancetype)shareInstance {
    static MSYLagMonitor *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - public methods

/// 开始监视卡顿
- (void)beginMonitor {
    //检测卡顿
    if (_runLoopObserver) {
        return;
    }
    
    //保证线程同步
    _semaphore = dispatch_semaphore_create(0);
    //创建一个观察者
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL};
    _runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                               kCFRunLoopAllActivities,
                                               YES,
                                               0xFFFFFF,
                                               &MSYRunLoopObserverCallBack,
                                               &context);
    //将观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), _runLoopObserver, kCFRunLoopCommonModes);
    //创建子线程监控
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程开启一个持续的loop用来进行监控
        while (YES) {
            //NSEC_PER_MSEC: 1毫秒 = 100万纳秒 20毫秒
            long semaphoreWait = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_MSEC));
            if (semaphoreWait != 0) {
                if (!self->_runLoopObserver) {
                    self->_timeoutCount = 0;
                    self->_semaphore = 0;
                    self->_runLoopActivity = 0;
                    return;
                }
                
                //两个runloop的状态，BeforeSources和AfterWaiting这两个状态区间时间能够检测到是否卡顿
                if (self->_runLoopActivity == kCFRunLoopBeforeSources ||
                    self->_runLoopActivity == kCFRunLoopAfterWaiting) {
                    if (++self->_timeoutCount < 1) {
                        continue;
                    }
                    
                    NSLog(@"monitor trigger");
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                        [SMCallStack callStackWithType:SMCallStackTypeAll];
                    });
                }
            }
            
            self->_timeoutCount = 0;
        }
    });
}

/// 停止监视卡顿
- (void)endMonitor {
    if (!_runLoopObserver) {
        return;
    }
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(_runLoopObserver);
    _runLoopObserver = NULL;
}

#pragma mark - private methods

#pragma mark - getter && setter

@end
