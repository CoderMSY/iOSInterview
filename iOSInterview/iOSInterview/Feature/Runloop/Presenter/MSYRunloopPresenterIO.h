//
//  MSYRunloopPresenterIO.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYRunloopPresenterInput <NSObject>

- (void)pushRunLoopImageWithTitle:(NSString *)title;

@end

@protocol MSYRunloopPresenterOut <NSObject>

@end

NS_ASSUME_NONNULL_END
