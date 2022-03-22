//
//  MSYLagMonitor.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYLagMonitor : NSObject

+ (instancetype)shareInstance;
/// 开始监视卡顿
- (void)beginMonitor;
/// 停止监视卡顿
- (void)endMonitor;

@end

NS_ASSUME_NONNULL_END
