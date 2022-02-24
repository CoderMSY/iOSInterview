//
//  MSYBasicPresenterIO.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYBasicPresenterInput <NSObject>

- (void)fetchDataSource;

- (void)pushThreadViewCtrWithTitle:(NSString *)title;
- (void)pushGCDViewCtrWithTitle:(NSString *)title;
- (void)pushOperationViewCtrWithTitle:(NSString *)title;
- (void)pushRuntimeViewCtr;
- (void)pushRunloopViewCtr;
- (void)pushAutoreleasePoolViewCtr;
- (void)pushCollectionExample;

@end

@protocol MSYBasicPresenterOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end



NS_ASSUME_NONNULL_END
