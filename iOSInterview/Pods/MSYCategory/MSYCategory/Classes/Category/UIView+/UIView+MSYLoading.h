//
//  UIView+MSYLoading.h
//
//
//  Created by SimonMiao on 2017/12/13.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MSYLoading)

/// 无标题缓冲视图
- (void)msy_postLoading;
- (void)msy_postLoadingWithTitle:(NSString *)title;
- (void)msy_postLoadingWithTitle:(NSString *)title detail:(NSString *)detail;
- (void)msy_postLoadingWithTitle:(NSString *)title contentColor:(UIColor *)contentColor;

/** 自动隐藏message 默认时间为2秒 */
- (void)msy_postMessage:(NSString *)message;
- (void)msy_postMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)msy_postMessageWithTitle:(NSString *)title detail:(NSString *)detail contentColor:(UIColor *)contentColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration;

///隐藏loading视图
- (void)msy_hideLoading;
- (void)msy_hideLoadingWithAfterDelay:(CGFloat)afterDelay;

@end
