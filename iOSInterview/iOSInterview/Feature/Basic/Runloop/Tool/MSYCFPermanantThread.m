//
//  MSYCFPermanantThread.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/28.
//

#import "MSYCFPermanantThread.h"
#import "MSYThread.h"


@interface MSYCFPermanantThread()

@property (nonatomic, strong) MSYThread *innerThread;

@end

@implementation MSYCFPermanantThread

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.innerThread = [[MSYThread alloc] initWithBlock:^{
            NSLog(@"begin----");
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext content = {0};
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &content);
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            // 销毁
            CFRelease(source);
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
//            while (weakSelf && !weakSelf.isStopped) {
//                // 第3个参数：returnAfterSourceHandled，设置为true，代表执行完source后就会退出当前loop
//                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
//            }
            NSLog(@"end----");
        }];
        
        [self.innerThread start];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [self stop];
}

#pragma mark - public methods

- (void)executeTask:(MJCFPermenantThreadTask)task {
    if (!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

#pragma mark - private methods

- (void)__stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(MJCFPermenantThreadTask)task {
    task();
}

#pragma mark - getter && setter



@end
