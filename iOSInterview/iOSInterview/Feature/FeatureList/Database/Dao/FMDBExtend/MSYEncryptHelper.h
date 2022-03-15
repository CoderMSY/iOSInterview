//
//  MSYEncryptHelper.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYEncryptHelper : NSObject

/** 对数据库加密 */
+ (BOOL)encryptDatabase:(NSString *)path;

/** 对数据库解密 */
+ (BOOL)decryptDatabase:(NSString *)path;

/** 对数据库加密 */
+ (BOOL)encryptDatabase:(NSString *)sourcePath
             targetPath:(NSString *)targetPath;

/** 对数据库解密 */
+ (BOOL)decryptDatabase:(NSString *)sourcePath
             targetPath:(NSString *)targetPath;

/** 修改数据库秘钥 */
+ (BOOL)changeKey:(NSString *)dbPath
        originKey:(NSString *)originKey
           newKey:(NSString *)newKey;

@end

NS_ASSUME_NONNULL_END
