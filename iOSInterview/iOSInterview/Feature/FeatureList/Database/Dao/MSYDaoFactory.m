//
//  MSYDaoFactory.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYDaoFactory.h"
#import "MSYDb1Dao.h"
#import "MSYDb2Dao.h"

@interface MSYDaoFactory ()

@property (nonatomic, strong) MSYDb1Dao *db1Dao;
@property (nonatomic, strong) MSYDb2Dao *db2Dao;

@end

@implementation MSYDaoFactory

+ (instancetype)sharedInstance {
    static MSYDaoFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSYDaoFactory alloc] init];
    });
    
    return instance;
}

#pragma mark - lifecycle methods

#pragma mark - public methods

- (id<MSYDb1DaoProtocol>)getDb1Dao {
    return self.db1Dao;
}

- (id<MSYDb2DaoProtocol>)getDb2Dao {
    return self.db2Dao;
}


#pragma mark - private methods

#pragma mark - getter && setter

- (MSYDb1Dao *)db1Dao {
    if (!_db1Dao) {
        _db1Dao = [[MSYDb1Dao alloc] init];
    }
    return _db1Dao;
}

- (MSYDb2Dao *)db2Dao {
    if (!_db2Dao) {
        _db2Dao = [[MSYDb2Dao alloc] init];
    }
    return _db2Dao;
}

@end
