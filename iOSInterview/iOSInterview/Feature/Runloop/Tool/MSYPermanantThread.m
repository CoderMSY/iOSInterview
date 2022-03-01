//
//  MSYPermanantThread.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import "MSYPermanantThread.h"
#import "MSYThread.h"

@interface MSYPermanantThread()

@property (strong, nonatomic) MSYThread *innerThread;
@property (assign, nonatomic, getter=isStopped) BOOL stopped;

@end

@implementation MSYPermanantThread

#pragma mark - lifecycle methods

- (instancetype)init {
    if (self = [super init]) {
        self.stopped = NO;
        
        __weak typeof(self) weakSelf = self;
        
        self.innerThread = [[MSYThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                
                //RunLoop的run方法是无限循环，无法停止，适合用于开启一个永不销毁的线程
//                [[NSRunLoop currentRunLoop] run];
            }
        }];
        
        [self.innerThread start];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [self stop];
}

#pragma mark - public methods

- (void)executeTask:(MSYPermanantThreadTask)task {
    if (!_innerThread || !task) {
        return;
    }
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:YES];
    NSLog(@"串行执行 阻塞:%s", __func__);
}

- (void)stop {
    if (!_innerThread) {
        return;
    }
    //waitUntilDone传NO有时可能会崩溃，传NO即dealloc和stop会同时执行，即dealloc执行完了，控制器销毁，stop还在可能在访问self，导致坏内存访问
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
    
    NSLog(@"串行执行 阻塞:%s", __func__);
}


#pragma mark - private methods

- (void)__stop {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(MSYPermanantThreadTask)task {
    task();
}

#pragma mark - getter && setter

@end
