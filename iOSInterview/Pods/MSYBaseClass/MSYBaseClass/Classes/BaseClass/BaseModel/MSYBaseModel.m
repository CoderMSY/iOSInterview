//
//  MSYBaseModel.m
//  
//
//  Created by Simon Miao on 2021/3/25.
//  Copyright © 2021 sjyyt. All rights reserved.
//

#import "MSYBaseModel.h"

@implementation MSYBaseModel

+ (MSYBaseModel *)decodeFromDic:(NSDictionary *)dic {
    NSLog(@"子类请实现转模型方法");
    return nil;
}

+ (NSArray *)decodeFromArray:(NSArray *)list {
    NSLog(@"子类请实现转模型数组方法");
    
    return nil;
}

@end
