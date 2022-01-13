//
//  MSYBaseModel.h
//  
//
//  Created by Simon Miao on 2021/3/25.
//  Copyright © 2021 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYBaseModel : NSObject

+ (MSYBaseModel *)decodeFromDic:(NSDictionary *)dic;

+ (NSArray *)decodeFromArray:(NSArray *)list;

@end

NS_ASSUME_NONNULL_END
