//
//  UIViewController+MSYHelper.m
//
//
//  Created by Simon Miao on 2021/4/19.
//

#import "UIViewController+MSYHelper.h"

@implementation UIViewController (MSYHelper)

- (UIViewController *)msy_currentActiveCtr {
    UIViewController *ctr = [UIViewController msy_currentActiveCtr];
    
    return ctr;
}

+ (UIViewController *)msy_currentActiveCtr {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    NSLog(@"windowLevel: %.0f", window.windowLevel);
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *rootVC = window.rootViewController;
    UIViewController *activeVC = nil;
        
    while (true) {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            activeVC = [(UINavigationController *)rootVC visibleViewController];
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
            activeVC = [(UITabBarController *)rootVC selectedViewController];
        } else if (rootVC.presentedViewController) {
            activeVC = rootVC.presentedViewController;
        } else if (rootVC.childViewControllers.count > 0) {
            activeVC = [rootVC.childViewControllers lastObject];
        } else {
            break;
        }
        rootVC = activeVC;
    }
    return activeVC;
}


@end
