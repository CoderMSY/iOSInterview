//
//  MSYDb1DaoProtocol.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYDb1DaoProtocol <NSObject>

/// 创建数据库表及插入数据
- (BOOL)createUnencryptDb1AndInsertData;
/// 读取未加密数据库
/// @param callback 结果回调
- (void)readUnencryptDb1:(void(^)(NSInteger count))callback;
/// 加密数据库
- (BOOL)encryptDb1;
/// 读取加密数据库
/// @param callback 结果回调
- (void)readEncrptDb1:(void(^)(NSInteger count))callback;
///解密数据库
- (BOOL)decryptDb1;

@end

NS_ASSUME_NONNULL_END
