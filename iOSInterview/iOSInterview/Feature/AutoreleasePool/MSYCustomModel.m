//
//  MSYCustomModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/7.
//

#import "MSYCustomModel.h"

@implementation MSYCustomModel

+ (void)initialize {
    NSLog(@"%s", __func__);
}

/**
 question:直接调用autorelease方法就可以把释放对象的任务交给Autoreleasepool对象，Autoreleasepool对象从哪里来？Autoreleasepool对象又会在何时调用[pool drain]方法？

 要解答以上两个问题，首先要了解NSRunLoop
 
 对于每一个Runloop运行循环，系统会隐式创建一个Autoreleasepool对象，+ (instancetype)customModel中执行autorelease的操作就会将MSYCustomModel对象添加到这个系统隐式创建的Autoreleasepool对象中——这回答了Autoreleasepool对象从哪里来
 
 当Runloop执行完一系列动作没有更多事情要它做时，它会进入休眠状态，避免一直占用大量系统资源，或者Runloop要退出时会触发执行_objc_autoreleasePoolPop()方法相当于让Autoreleasepool对象执行一次drain方法，Autoreleasepool对象会对自动释放池中所有的对象依次执行依次release操作——这回答了Autoreleasepool对象又会在何时调用[pool drain]方法
 
 链接：https://www.jianshu.com/p/a2999d7728b4

 */
/** 可以看下ibireme 的 深入理解RunLoop,原话如下：
 App启动后，苹果在主线程 RunLoop 里注册了两个 Observer，其回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。

 第一个 Observer 监视的事件是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池。其 order 是-2147483647，优先级最高，保证创建释放池发生在其他所有回调之前。

 第二个 Observer 监视了两个事件： BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。
 */
+ (instancetype)customModel {
    MSYCustomModel *model = [[MSYCustomModel alloc] init];
    //MRC，加入自动释放池
//    [model autorelease];
    
    return model;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
