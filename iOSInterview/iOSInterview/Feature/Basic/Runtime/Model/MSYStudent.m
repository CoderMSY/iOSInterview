//
//  MSYStudent.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/16.
//

#import "MSYStudent.h"

@implementation MSYStudent

- (void)msy_studentInstanceMethod {
    NSLog(@"%s", __func__);
    [self msy_studentInstanceMethod];
}

- (void)msy_studentInstanceMethodIsImpl {
    NSLog(@"%s", __func__);
    /** 栈溢出，递归死循环了
     oriMethod未实现，找不到方法
     此时的msy_studentInstanceMethodIsImpl并没有指向oriMethod ，然后导致了自己调自己，即递归死循环
     */
    [self msy_studentInstanceMethodIsImpl];
}

+ (void)msy_studentClassMethod {
    NSLog(@"%s", __func__);
    [self msy_studentClassMethod];
}

+ (void)msy_studentClassMethodIsImpl {
    NSLog(@"%s", __func__);
    [self msy_studentClassMethodIsImpl];
}

@end
