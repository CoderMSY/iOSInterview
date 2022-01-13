//
//  MSYBaseViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/23.
//

#import "MSYBaseViewController.h"

@interface MSYBaseViewController ()

@end

@implementation MSYBaseViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

// Objective-C:InjectionIII热重载
- (void)injected {
    #ifdef DEBUG
        NSLog(@"I've been injected: %@", self);
        [self viewDidLoad];
    #endif
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - getter && setter

@end
