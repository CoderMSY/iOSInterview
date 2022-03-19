//
//  MSYPerson.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import "MSYPerson.h"
#import <objc/runtime.h>
#import "MSYOtherPerson.h"

@implementation MSYPerson

- (void)run
{
    NSLog(@"%s", __func__);
}

- (void)test
{
    NSLog(@"%s", __func__);
}

- (void)personInstanceMethod {
    NSLog(@"%s", __func__);
}

+ (void)personClassMethod {
    NSLog(@"%s", __func__);
}

#pragma mark - runtime
//动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(unrecognizedMethod)) {
//        Method method = class_getInstanceMethod(self, @selector(test));
//        class_addMethod(self,
//                        sel,
//                        method_getImplementation(method),
//                        method_getTypeEncoding(method));
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}
/** 消息转发
 */
///快速消息转发阶段
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(unrecognizedMethod)) {
//        return [[MSYOtherPerson alloc] init];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

//方法签名：返回值类型、参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if (aSelector == @selector(unrecognizedMethod)) {
//        MSYOtherPerson *other = [[MSYOtherPerson alloc] init];
//        NSMethodSignature *signature = [other methodSignatureForSelector:@selector(unrecognizedMethod)];
//        return signature;
//    }
    return [super methodSignatureForSelector:aSelector];
}
//方法调用者、方法名、方法参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    MSYOtherPerson *other = [[MSYOtherPerson alloc] init];

    anInvocation.target = other;
    [anInvocation invoke];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"%s:%@", __func__, NSStringFromSelector(aSelector));
}

@end
