//
//  MSYProxy.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import "MSYProxy.h"

@implementation MSYProxy

+ (instancetype)proxyWithTarget:(id)target {
    MSYProxy *proxy = [[MSYProxy alloc] init];
    proxy.target = target;
    
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
