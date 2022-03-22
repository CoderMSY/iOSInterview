//
//  MSYAllPortsProtocol.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYAllPortsProtocol <NSObject>

@optional
- (void)typeC;
- (void)microUSB;
- (void)vga;
- (void)hdmi;

@end

NS_ASSUME_NONNULL_END
