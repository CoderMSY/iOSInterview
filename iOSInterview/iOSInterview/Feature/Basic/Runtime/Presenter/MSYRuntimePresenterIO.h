//
//  MSYRuntimePresenterIO.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYRuntimePresenterInput <NSObject>

- (void)fetchDataSource;

@end

@protocol MSYRuntimePresenterOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
