//
//  MSYHashTable.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/24.
//

#import <Foundation/Foundation.h>
@class MSYSingleLinkedNode;

NS_ASSUME_NONNULL_BEGIN

@interface MSYHashTable : NSObject

@property (nonatomic, strong) NSMutableArray *elementArray;

/// 容量  数组（hash表）长度
@property (nonatomic, assign) NSInteger capacity;
/// 计数器，计算put的元素个数（不包括重复的元素）
@property (nonatomic, assign) NSInteger modCount;
/// 阈值
@property (nonatomic, assign) float threshold;
/// 加载因子 = 阈值 / 容量
@property (nonatomic, assign) float loadFactor;


/// 初始化Hash表
/// @param capacity 数组的长度
- (instancetype)initWithCapacity:(NSInteger)capacity;

/// 插入
/// @param newNode 存入的键值对newNode
- (void)insertElementByNode:(MSYSingleLinkedNode *)node;

/// 查询
/// @param key 值
- (NSString *)findElementByKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
