//
//  MSYInterfaceAdapter.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import "MSYInterfaceAdapter.h"

@implementation MSYInterfaceAdapter

#pragma mark - MSYAllPortsProtocol

- (void)typeC {
    NSLog(@"%s", __func__);
}

- (void)microUSB {
    NSLog(@"%s", __func__);
}

- (void)vga {
    NSLog(@"%s", __func__);
}

- (void)hdmi {
    NSLog(@"%s", __func__);
}

@end
