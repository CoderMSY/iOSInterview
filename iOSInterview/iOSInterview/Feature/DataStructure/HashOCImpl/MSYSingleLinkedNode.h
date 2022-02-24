//
//  MSYSingleLinkedNode.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYSingleLinkedNode : NSObject <NSCopying>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) MSYSingleLinkedNode *next;
@property (nonatomic, assign) NSInteger hashValue;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;
+ (instancetype)nodeWithKey:(NSString *)key value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
