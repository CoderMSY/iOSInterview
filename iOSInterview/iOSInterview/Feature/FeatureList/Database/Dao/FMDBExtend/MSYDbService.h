//
//  MSYDbService.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;

NS_ASSUME_NONNULL_BEGIN

@interface MSYDbService : NSObject

@property (nonatomic, strong) FMDatabaseQueue *queue;

- (instancetype)initWithPath:(NSString *)path encrypt:(BOOL)isEncrypted;
+ (void)setEncryptKey:(NSString *)encryptKey;

- (BOOL)executeUpdate:(NSString *)sql param:(NSArray *_Nullable)param;
- (NSInteger)findRowCount:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
