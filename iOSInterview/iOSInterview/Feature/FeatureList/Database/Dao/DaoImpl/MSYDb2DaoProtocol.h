//
//  MSYDb2DaoProtocol.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYDb2DaoProtocol <NSObject>

- (BOOL)createEncryptDb2;
- (void)readEncryptDb2:(void(^)(NSInteger count))callback;
- (BOOL)decryptDb2;
- (void)readDecryptDb2:(void(^)(NSInteger count))callback;
- (BOOL)encrptDb2;

@end

NS_ASSUME_NONNULL_END
