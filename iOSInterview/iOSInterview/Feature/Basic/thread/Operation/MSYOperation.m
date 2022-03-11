//
//  MSYOperation.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/17.
//

#import "MSYOperation.h"

@implementation MSYOperation
//重写main方法，适用于业务逻辑较多，功能较复杂的操作
- (void)main {
    NSLog(@"%s:%@", __func__, [NSThread currentThread]);
    
    //耗时操作1
    for (NSInteger i = 0; i < 10000; i++) {
        NSLog(@"任务1:%@-%ld--%@", self.name, (long)i , [NSThread currentThread]);
    }
    
    //apple官方建议：每当执行完一次耗时操作时，可以检查当前队列是否取消状态，如果是，则直接退出，以此提高程序性能
    if (self.isCancelled) {
        return;
    }
    NSLog(@"+++++++++++");
    
    //耗时操作2
    for (NSInteger i = 0; i < 10000; i++) {
        NSLog(@"任务2:%@-%ld--%@", self.name, (long)i , [NSThread currentThread]);
    }
    
    if (self.isCancelled) {
        return;
    }
    NSLog(@"+++++++++++");
    
    //耗时操作3
    for (NSInteger i = 0; i < 10000; i++) {
        NSLog(@"任务3:%@-%ld--%@", self.name, (long)i , [NSThread currentThread]);
    }
    
    NSLog(@"+++++++++++");
}

@end
