//
//  MSYDb2Dao.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYDb2Dao.h"
//#import "MSYEncryptDatabase.h"
#import "MSYDbService.h"
#import "MSYEncryptHelper.h"

@interface MSYDb2Dao ()
{
    NSString *_dbPath2;
    NSString *_originKey;
    NSString *_newKey;
}

//@property (nonatomic, strong) MSYDbService *dbService;

@end

@implementation MSYDb2Dao

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        _dbPath2 = [directory stringByAppendingPathComponent:@"db2.db"];
        
        _originKey = @"aaa";
        _newKey = @"bbb";
    }
    return self;
}

#pragma mark - MSYDb2DaoProtocol

- (BOOL)createEncryptDb2 {
//    self.dbService.isEncrypted = YES;
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath2 encrypt:YES];
    BOOL isCreate = [self createTable:dbService];
    if (isCreate) {
        [self insertPeople:dbService];
        
        return YES;
    }
    
    return NO;
}

- (void)readEncryptDb2:(void(^)(NSInteger count))callback {
//    self.dbService.isEncrypted = YES;
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath2 encrypt:YES];
    NSInteger count = [dbService findRowCount:@"People"];
    
    if (callback) {
        callback(count);
    }
}

- (BOOL)decryptDb2 {
    BOOL isSuccess = [MSYEncryptHelper decryptDatabase:_dbPath2];
    
    return isSuccess;
}

- (void)readDecryptDb2:(void(^)(NSInteger count))callback {
    MSYDbService *dbService = [[MSYDbService alloc] initWithPath:_dbPath2 encrypt:NO];
    NSInteger count = [dbService findRowCount:@"People"];
    
    if (callback) {
        callback(count);
    }
}

- (BOOL)encrptDb2 {
    BOOL isSuccess = [MSYEncryptHelper encryptDatabase:_dbPath2];
    
    return isSuccess;
}

#pragma mark - getter && setter

//- (MSYDbService *)dbService {
//    if (!_dbService) {
//        _dbService = [[MSYDbService alloc] initWithPath:_dbPath2 encrypt:YES];
//    }
//    return _dbService;
//}

@end
