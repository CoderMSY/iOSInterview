//
//  ATNavigationController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "ATNavigationController.h"

@interface ATNavigationController ()

@end

@implementation ATNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - lifecycle methods

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - public methods

#pragma mark - private methods

#pragma mark - getter && setter

@end
