//
//  MSYAdapterViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//  参考：https://oldbird.run/design-patterns/#/AdapterPattern?id=%e7%b1%bb%e9%80%82%e9%85%8d%e5%99%a8

#import "MSYAdapterViewController.h"
#import "MSYClassAdapter.h"
#import "MSYInstanceAdapter.h"
#import "MSYInstancePhone.h"
#import "MSYTypeCToVGAAdapter.h"

@interface MSYAdapterViewController ()

@end

@implementation MSYAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.adapterType) {
        case MSYAdapterType_class:
            [self exampleClass];
            break;
        case MSYAdapterType_instance:
            [self exampleInstance];
            break;
        case MSYAdapterType_interface:
            [self exampleInterface];
            break;
            
        default:
            break;
    }
}

- (void)exampleClass {
    MSYClassAdapter *adapter = [[MSYClassAdapter alloc] init];
    [adapter microUSB];
}

- (void)exampleInstance {
    MSYInstancePhone *phone = [[MSYInstancePhone alloc] init];
    MSYInstanceAdapter *adapter = [[MSYInstanceAdapter alloc] initWithTypeC:phone];
    [adapter microUSB];
}

- (void)exampleInterface {
    MSYTypeCToVGAAdapter *adapter = [[MSYTypeCToVGAAdapter alloc] init];
    [adapter typeC];
    [adapter vga];
}

@end
