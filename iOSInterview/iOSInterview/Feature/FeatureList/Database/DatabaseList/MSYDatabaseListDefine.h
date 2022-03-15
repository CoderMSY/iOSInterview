//
//  MSYDatabaseListDefine.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#ifndef MSYDatabaseListDefine_h
#define MSYDatabaseListDefine_h

static NSString *const kSecDatabase_SQL = @"数据库";
static NSString *const kRowDatabase_createUnEncrptedDb1 = @"创建非加密数据库Db1";
static NSString *const kRowDatabase_readUnEncrptedDb1 = @"读取非加密数据库Db1";
static NSString *const kRowDatabase_encrptDb1 = @"给Db1加密";
static NSString *const kRowDatabase_readEncrptDb1 = @"读取加密数据库Db1";
static NSString *const kRowDatabase_decryptDb1 = @"给Db1解密";

static NSString *const kRowDatabase_createEncrptedDb2 = @"创建加密数据库Db2(数据库文件加密)";
static NSString *const kRowDatabase_readEncrptedDb2 = @"读取加密数据库-Db2";
static NSString *const kRowDatabase_decryptDb2 = @"给Db2解密";
static NSString *const kRowDatabase_readDecryptDb2 = @"读取解密数据库Db2";
static NSString *const kRowDatabase_encrptDb2 = @"给Db2加密";


#endif /* MSYDatabaseListDefine_h */
