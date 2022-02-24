//
//  MSYSingleLinkedNode.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/24.
//

#import "MSYSingleLinkedNode.h"

@implementation MSYSingleLinkedNode

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value {
    if (self = [super init]) {
        _key = key;
        _value = value;
    }
    return self;
}

+ (instancetype)nodeWithKey:(NSString *)key value:(NSString *)value {
    return [[[self class] alloc] initWithKey:key value:value];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    MSYSingleLinkedNode *newNode = [[MSYSingleLinkedNode allocWithZone:zone] init];
    newNode.key = self.key;
    newNode.value = self.value;
//    newNode.next = self.next;
    
    return newNode;
}

@end
