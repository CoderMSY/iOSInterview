//
//  NSObject+MSYJson.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import "NSObject+MSYJson.h"
#import <objc/runtime.h>

@implementation NSObject (MSYJson)

+ (instancetype)msy_objectWithJson:(NSDictionary *)json {
    id obj = [[self alloc] init];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        [name deleteCharactersInRange:NSMakeRange(0, 1)];
        
        id value = json[name];
        if ([name isEqualToString:@"ID"]) {
            value = json[@"id"];
        }
        
        [obj setValue:value forKey:name];
    }
    free(ivars);
    
    return obj;
}

@end
