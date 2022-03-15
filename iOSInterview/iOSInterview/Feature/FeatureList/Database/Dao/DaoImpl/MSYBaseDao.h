//
//  MSYBaseDao.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import <Foundation/Foundation.h>
#import "MSYDbService.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYBaseDao : NSObject

- (BOOL)createTable:(MSYDbService *)service;
- (BOOL)insertPeople:(MSYDbService *)service;

@end

NS_ASSUME_NONNULL_END
