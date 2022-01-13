//
//  UIViewController+MSYHookHelper.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/23.
//

#import "UIViewController+MSYHookHelper.h"
#import <objc/runtime.h>

@implementation UIViewController (MSYHookHelper)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self addHook];
//    });
}

+ (void)addHook {
    Method originalMethod = class_getInstanceMethod([UIViewController class], @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod([UIViewController class], @selector(msy_viewWillAppear:));
    BOOL addSucc = class_addMethod([UIViewController class],
                                   @selector(viewWillAppear:),
                                   method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (addSucc) {
        //如果方法已经存在
        class_replaceMethod([UIViewController class], @selector(msy_viewWillAppear:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)msy_viewWillAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
    if ([className hasPrefix:@"UI"] == NO) {
        NSLog(@"%@ will appear OOOOOO",className);
    }
    //下面方法的调用，其实是调用viewWillAppear
    [self msy_viewWillAppear:animated];
}

@end
