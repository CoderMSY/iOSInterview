//
//  MSYTypeCToVGAAdapter.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import "MSYTypeCToVGAAdapter.h"

@implementation MSYTypeCToVGAAdapter

- (void)typeC {
    NSLog(@"%s:信号从TypeC接口进入", __func__);
}

- (void)vga {
    NSLog(@"%s:信号从VGA接口出来", __func__);
}

@end
