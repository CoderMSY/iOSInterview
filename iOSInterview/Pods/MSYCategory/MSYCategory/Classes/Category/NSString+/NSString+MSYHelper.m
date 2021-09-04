//
//  NSString+MSYHelper.m
//  
//
//  Created by Simon Miao on 2021/4/9.
//

#import "NSString+MSYHelper.h"

@implementation NSString (MSYHelper)

//判断字符串是否为空<null>
+ (BOOL)msy_isEmpty:(NSString *)value {
    if (!value) {
        return YES;
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return YES;
    }
    //创建一个字符集对象, 包含所有的空格和换行字符
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    //从字符串中过滤掉首尾的空格和换行, 得到一个新的字符串
    NSString *trimmedStr = [value stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}


@end
