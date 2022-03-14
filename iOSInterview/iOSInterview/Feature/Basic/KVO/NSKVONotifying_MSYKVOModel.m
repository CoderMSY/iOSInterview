//
//  NSKVONotifying_MSYKVOModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "NSKVONotifying_MSYKVOModel.h"

@implementation NSKVONotifying_MSYKVOModel

- (void)setAge:(NSInteger)age {
    _NSSetIntValueAndNotify();
}
// 伪代码
void _NSSetIntValueAndNotify() {
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key {
    // 通知监听器，某某属性值发生了改变
    [oberser observeValueForKeyPath:key ofObject:self change:nil context:nil];
}

/* KVO的本质是什么？
 1.利用RuntimeAPI动态生成一个子类，并且让instance对象的isa指向这个全新的子类
 2.当修改instance对象的属性时，会调用Foundation的_NSSetXXXValueAndNotify函数（_NSSetIntValueAndNotify）
 3._NSSetXXXValueAndValueNotify函数的内部实现如下：
    - willChangeValueForKey:
    - 父类原来的属性setter方法
    - didChangeValueForKey： 该方法内部会触发监听器（Oberser）的监听方法（observeValueForKeyPath：ofObject：change:context:）
 */

@end
