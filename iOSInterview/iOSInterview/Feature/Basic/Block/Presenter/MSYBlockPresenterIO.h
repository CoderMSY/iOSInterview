//
//  MSYBlockPresenterIO.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYBlockPresenterInput <NSObject>

- (void)fetchDataSource;

@end

@protocol MSYBlockPresenterOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
