//
//  MSYHookHelper.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/16.
//

#import "MSYHookHelper.h"
#import <Objc/runtime.h>

@implementation MSYHookHelper

+ (void)msy_swizzleInstanceWithClass:(Class)cls
                         originalSel:(SEL)originalSel
                         swizzledSel:(SEL)swizzledSel {
    if (!cls) NSLog(@"传入的交换类不能为空");
    
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    if (!originalMethod) {
        // TODO: 有bug
        // 在oriMethod为nil时，替换后将swizzledSEL复制一个不做任何事的空实现,代码如下:
        IMP emptyImpl = imp_implementationWithBlock(^(id target, SEL _cmd){
            NSLog(@"%s target:%@", __FUNCTION__, target);
        });
        class_addMethod(cls, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        method_setImplementation(swizzledMethod, emptyImpl);
    }
    
    BOOL isSuccess = class_addMethod(cls, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isSuccess) { // 自己没有 - 交换 - 没有父类进行处理 (重写一个)
        class_replaceMethod(cls, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

//+ (void)msy_swizzleInstanceWithClass:(Class)cls
//                         originalSel:(SEL)originalSel
//                         swizzledSel:(SEL)swizzledSel {
//    Method originalMethod = class_getInstanceMethod(cls, originalSel);
//    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
//
//    BOOL isSuccess = class_addMethod(cls, originalSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    if (isSuccess) {
//        originalMethod = class_getInstanceMethod(cls, originalSel);
//    }
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}

+ (void)msy_swizzleClassWithClass:(Class)cls
                      originalSel:(SEL)originalSel
                      swizzledSel:(SEL)swizzledSel {
    if (!cls) NSLog(@"传入的交换类不能为空");
    Method oriMethod = class_getClassMethod([cls class], originalSel);
    Method swiMethod = class_getClassMethod([cls class], swizzledSel);
    
    if (!oriMethod) {
        // 在oriMethod为nil时，替换后将swizzledSEL复制一个不做任何事的空实现,代码如下:
        class_addMethod(object_getClass(cls), originalSel, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){
            NSLog(@"来了一个空的 imp");
        }));
    }
    
    BOOL didAddMethod = class_addMethod(object_getClass(cls), originalSel, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    if (didAddMethod) {
        class_replaceMethod(object_getClass(cls), swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}

@end
