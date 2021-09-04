//
//  UIView+MSYHelper.m
//  
//
//  Created by Simon Miao on 2021/4/12.
//

#import "UIView+MSYHelper.h"

@implementation UIView (MSYHelper)

- (UIViewController *)msy_viewController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (CGFloat)msy_getSafeAreaTop {
    CGFloat safeTop = 0;
    if (@available(iOS 11.0, *)) {
        safeTop = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    return safeTop;
}

- (CGFloat)msy_getSafeAreaTop {
    CGFloat safeTop = [UIView msy_getSafeAreaTop];
    
    return safeTop;
}

+ (CGFloat)msy_getSafeAreaBottom {
    CGFloat safeBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return safeBottom;
}

- (CGFloat)msy_getSafeAreaBottom {
    CGFloat safeBottom = [UIView msy_getSafeAreaBottom];
    
    return safeBottom;
}

@end
