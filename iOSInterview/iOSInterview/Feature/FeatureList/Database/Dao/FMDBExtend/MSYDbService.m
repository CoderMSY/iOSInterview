//
//  MSYDbService.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYDbService.h"
#import <FMDB/FMDB.h>

static NSString *encryptKey_ = @"FDLSAFJEIOQJR34JRI4JIGR93209T489FR";

@interface MSYDbService ()

@end

@implementation MSYDbService

- (instancetype)initWithPath:(NSString *)path encrypt:(BOOL)isEncrypted
{
    if (self = [super init]) {
        
        if (isEncrypted) {
            _queue = [FMDatabaseQueue databaseQueueWithPath:path];
            [_queue inDatabase:^(FMDatabase * _Nonnull db) {
                [db setKey:encryptKey_];
            }];
        } else {
            _queue = [FMDatabaseQueue databaseQueueWithPath:path];
        }
    }
    
    return self;
}

+ (void)setEncryptKey:(NSString *)encryptKey
{
    encryptKey_ = encryptKey;
}

- (BOOL)executeUpdate:(NSString *)sql param:(NSArray *)param {
    __block BOOL result = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        if (param && param.count > 0) {
            result = [db executeUpdate:sql withArgumentsInArray:param];
        } else {
            result = [db executeUpdate:sql];
        }
    }];
    
    return result;
}

- (id)executeScalar:(NSString *)sql param:(NSArray *)param
{
    __block id result;
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:param];
        if ([rs next]) {
            result = rs[0];
        } else {
            result = 0;
        }
        [rs close];
    }];
    return result;
}

- (NSInteger)findRowCount:(NSString *)tableName {
    NSNumber *number = (NSNumber *)[self executeScalar:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@", tableName] param:nil];
    return [number longValue];
}

@end
