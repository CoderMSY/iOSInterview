//
//  MSYDaoFactory.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import <Foundation/Foundation.h>
#import "MSYDb1DaoProtocol.h"
#import "MSYDb2DaoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define _DaoFactory [MSYDaoFactory sharedInstance]

@interface MSYDaoFactory : NSObject

+ (instancetype)sharedInstance;

- (id<MSYDb1DaoProtocol>)getDb1Dao;
- (id<MSYDb2DaoProtocol>)getDb2Dao;

@end

NS_ASSUME_NONNULL_END
