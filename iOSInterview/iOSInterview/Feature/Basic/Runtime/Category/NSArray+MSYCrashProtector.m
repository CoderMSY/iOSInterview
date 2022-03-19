//
//  NSArray+MSYCrashProtector.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/17.
//

#import "NSArray+MSYCrashProtector.h"
#import <objc/runtime.h>
#import "MSYHookHelper.h"

@implementation NSArray (MSYCrashProtector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不可变数组
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSArrayI") originalSel:@selector(objectAtIndex:) swizzledSel:@selector(arrayI_objectAtIndex:)];
        //可变数组
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSArrayM") originalSel:@selector(objectAtIndex:) swizzledSel:@selector(arrayM_objectAtIndex:)];
        //_NSSingleObjectArrayI：单元素数组
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSSingleObjectArrayI") originalSel:@selector(objectAtIndex:) swizzledSel:@selector(singleObjectArrayI_objectAtIndex:)];
        
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSArrayI") originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(arrayI_objectAtIndexedSubscript:)];
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSArrayM") originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(arrayM_objectAtIndexedSubscript:)];
        [MSYHookHelper msy_swizzleInstanceWithClass:objc_getClass("__NSSingleObjectArrayI") originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(singleObjectArrayI_objectAtIndexedSubscript:)];
        
    });
}

- (id)arrayI_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self arrayI_objectAtIndex:index];
    }
    
    @try {
        return [self arrayI_objectAtIndex:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}

- (id)arrayM_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self arrayM_objectAtIndex:index];
    }
    
    @try {
        return [self arrayM_objectAtIndex:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}

- (id)singleObjectArrayI_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self singleObjectArrayI_objectAtIndex:index];
    }
    
    @try {
        return [self singleObjectArrayI_objectAtIndex:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}
/*
- (id)msy_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self msy_objectAtIndex:index];
    }
    
//#ifdef DEBUG
//    return [self msy_objectAtIndex:index];
//#else
    @try {
        return [self msy_objectAtIndex:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
//#endif
}
 */

//array[0] 越界
- (id)arrayI_objectAtIndexedSubscript:(NSUInteger)index {
    if (index < self.count) {
        return [self arrayI_objectAtIndexedSubscript:index];
    }
    
    @try {
        return [self arrayI_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}

- (id)arrayM_objectAtIndexedSubscript:(NSUInteger)index {
    if (index < self.count) {
        return [self arrayM_objectAtIndexedSubscript:index];
    }
    
    @try {
        return [self arrayM_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}

- (id)singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)index {
    if (index < self.count) {
        return [self singleObjectArrayI_objectAtIndexedSubscript:index];
    }
    
    @try {
        return [self singleObjectArrayI_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        // 在崩溃后会打印崩溃信息，方便我们调试。
        NSLog(@"---------- %s Crash Because Method %s description:%@ ----------\n", class_getName(self.class), __func__, exception.description);
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    } @finally {
        //
    }
}

@end
