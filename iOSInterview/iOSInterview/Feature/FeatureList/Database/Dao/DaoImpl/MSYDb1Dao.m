//
//  MSYDb1Dao.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYDb1Dao.h"
#import "MSYDbService.h"
#import "MSYEncryptHelper.h"

@interface MSYDb1Dao ()
{
    NSString *_dbPath1;
}

//@property (nonatomic, strong) MSYDbService *dbService;

@end

@implementation MSYDb1Dao

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        _dbPath1 = [directory stringByAppendingPathComponent:@"db1.db"];
    }
    return self;
}

#pragma mark - MSYDb1DaoProtocol

- (BOOL)createUnencryptDb1AndInsertData {
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath1 encrypt:NO];
    BOOL isSuccess = [self createTable:dbService];
    if (isSuccess) {
        isSuccess = [self insertPeople:dbService];
    }
    
    return isSuccess;
}

- (void)readUnencryptDb1:(void (^)(NSInteger))callback {
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath1 encrypt:NO];
    NSInteger count = [dbService findRowCount:@"People"];
    if (callback) {
        callback(count);
    }
}

- (BOOL)encryptDb1 {
    BOOL isSuccess = [MSYEncryptHelper encryptDatabase:_dbPath1];
    
    return isSuccess;
}

- (void)readEncrptDb1:(void(^)(NSInteger count))callback {
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath1 encrypt:YES];
    NSInteger count = [dbService findRowCount:@"People"];
    if (callback) {
        callback(count);
    }
}

- (BOOL)decryptDb1 {
    BOOL isSuccess = [MSYEncryptHelper decryptDatabase:_dbPath1];
    
    return isSuccess;
}

#pragma mark - private methods

#pragma mark - getter && setter

//- (MSYDbService *)dbService {
//    if (!_dbService) {
//        _dbService = [[MSYDbService alloc] initWithPath:_dbPath1 encrypt:NO];
//    }
//    return _dbService;
//}

@end
