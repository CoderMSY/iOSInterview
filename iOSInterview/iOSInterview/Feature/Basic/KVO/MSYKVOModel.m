//
//  MSYKVOModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "MSYKVOModel.h"

@implementation MSYKVOModel

- (void)setAge:(int)age {
    _age = age;
    
    NSLog(@"%s: %d", __func__, age);
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    
    NSLog(@"%s: %@", __func__, key);
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%s: %@ - begin", __func__, key);
    /* didChangeValueForKey：
     该方法内部会触发监听器（Oberser）的监听方法（observeValueForKeyPath：ofObject：change:context:）
    */
    [super didChangeValueForKey:key];
    
    NSLog(@"%s: %@ - end", __func__, key);
}

@end
