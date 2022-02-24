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
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)dealloc {
    NSLog(@"%s:%@", __func__, NSStringFromClass([self class]));
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
