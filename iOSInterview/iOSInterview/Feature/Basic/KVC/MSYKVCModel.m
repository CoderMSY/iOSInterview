//
//  MSYKVCModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYKVCModel.h"

@implementation MSYKVCModel

#pragma mark - setValue:forKey: 原理

/** setValue:forKey: 原理
 1.按照setKey:、_setKey: 顺序查找方法，找到方法，传递参数，调用方法
 2.没找到方法，查看accessInstanceVariablesDirectly方法返回值（默认返回值为YES），NO则调用setValue:forUndefinedKey:
 3.按照_key、_isKey、key、isKey的顺序查找成员变量

 */
//- (void)setAge:(int)age {
//    NSLog(@"%s %d", __func__, age);
//}

//- (void)_setAge:(int)age {
//    NSLog(@"%s %d", __func__, age);
//}

#pragma mark - valueForKey: 原理
/** valueForKey: 原理
 按照getKey、key、isKey、_key的顺序查找
 如果accessInstanceVariablesDirectly返回YES，就直接查询成员变量，否则直接崩溃
 按照_key、_isKey、key、isKey的顺序查找成员变量
 */

//- (int)getAge {
//    return 10;
//}

//- (int)age {
//    return 11;
//}

//- (int)isAge {
//    return 12;
//}

//- (int)_age {
//    return 13;
//}

// 默认的返回值就是YES
+ (BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"setValue:%@ forUndefinedKey:%@", value, key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"valueForUndefinedKey:%@", key);
    return nil;
}

@end
