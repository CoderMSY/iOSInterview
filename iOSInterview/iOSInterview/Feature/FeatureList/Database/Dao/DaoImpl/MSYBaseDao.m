//
//  MSYBaseDao.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYBaseDao.h"

@implementation MSYBaseDao

- (BOOL)createTable:(MSYDbService *)service
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS People (        \
                        id INTEGER PRIMARY KEY AUTOINCREMENT,   \
                        str1 TEXT,                              \
                        str2 TEXT,                              \
                        float1 REAL,                            \
                        double1 INTEGER,                        \
                        short1 REAL,                            \
                        long1 REAL,                             \
                        date1 TEXT,                             \
                        bool1 INTEGER,                          \
                        data1 BLOB                              \
    )";
    return [service executeUpdate:sql param:nil];
}

- (BOOL)insertPeople:(MSYDbService *)service
{
    NSString *sql = @"insert into People(str1, str2, float1, double1, short1, long1, date1, bool1, data1) values(?,?,?,?,?,?,?,?,?)";
    
    NSString *text = @"dataValue";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *param = @[@"bomo", @"male", @70, @175l, @22, @123, [NSDate date], @NO, data];
    
    BOOL isSuccess = YES;
    for (int i = 0; i < 100; i++) {
        BOOL isResult = [service executeUpdate:sql param:param];
        if (!isResult) {
            isSuccess = isResult;
        }
    }
    
    return isSuccess;
}

@end
