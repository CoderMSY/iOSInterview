//
//  MSYAdapterViewController.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/22.
//

#import "MSYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYAdapterType) {
    MSYAdapterType_class,      //类适配器
    MSYAdapterType_instance,   //对象适配器
    MSYAdapterType_interface,  //接口适配器
};

@interface MSYAdapterViewController : MSYBaseViewController

@property (nonatomic, assign) MSYAdapterType adapterType;

@end

NS_ASSUME_NONNULL_END
