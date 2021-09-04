//
//  UIViewController+MSYHelper.h
//
//
//  Created by Simon Miao on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MSYHelper)

- (UIViewController *)msy_currentActiveCtr;
+ (UIViewController *)msy_currentActiveCtr;

@end

NS_ASSUME_NONNULL_END
