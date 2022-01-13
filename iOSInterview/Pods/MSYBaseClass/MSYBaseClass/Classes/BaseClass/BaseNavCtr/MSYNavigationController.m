//
//  MSYNavigationController.m
//  
//
//  Created by Simon Miao on 2021/4/19.
//

#import "MSYNavigationController.h"

@interface MSYNavigationController ()

@end

@implementation MSYNavigationController

#pragma mark - lifecycle methods

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.translucent = NO;
    }
    
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

#pragma mark - public methods


#pragma mark - private methods

- (void)backLastController {
    [self popViewControllerAnimated:YES];
}

#pragma mark - getter && setter

@end
