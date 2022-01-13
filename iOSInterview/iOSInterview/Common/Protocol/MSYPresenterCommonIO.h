//
//  MSYPresenterCommonIO.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYPresenterCommonInput <NSObject>

- (void)fetchDataSource;

@end

@protocol MSYPresenterCommonOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
