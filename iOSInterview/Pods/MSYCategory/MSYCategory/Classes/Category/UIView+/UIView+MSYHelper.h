//
//  UIView+MSYHelper.h
//
//
//  Created by Simon Miao on 2021/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MSYHelper)

/// 获取当前view所在的控制器
- (UIViewController *)msy_viewController;

+ (CGFloat)msy_getSafeAreaTop;
- (CGFloat)msy_getSafeAreaTop;

+ (CGFloat)msy_getSafeAreaBottom;
- (CGFloat)msy_getSafeAreaBottom;

@end

NS_ASSUME_NONNULL_END
