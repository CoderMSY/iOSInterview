//
//  MSYViewCtrIntercepter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/23.
//

#import "MSYViewCtrIntercepter.h"
#import <UIKit/UIKit.h>
#import <Aspects/Aspects.h>

@implementation MSYViewCtrIntercepter

#pragma mark - lifecycle methods

+ (void)load {
    [super load];
    
    [self sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MSYViewCtrIntercepter *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MSYViewCtrIntercepter alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addHook];
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)addHook {
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated) {
        [self msy_viewWillAppearWithAspectInfo:aspectInfo];
    } error:NULL];
}

- (void)msy_viewWillAppearWithAspectInfo:(id <AspectInfo>)aspectInfo {
    if ([aspectInfo.instance isKindOfClass:[UIViewController class]]) {
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
        if ([className hasPrefix:@"UI"] == NO) {
            NSLog(@"%@-->:%@", @"view will appear:😜😜😜", className);
        }
    }
}


#pragma mark - getter && setter

@end
