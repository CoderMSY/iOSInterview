//
//  UIImage+MSYBundle.h
//  MBProgressHUD
//
//  Created by Simon Miao on 2021/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MSYBundle)

/// 从bundle中获取资源图片
/// @param imageName 图片名称（不用带@2x，@3x,方法内部会判断scale）
/// @param bundleClass 当前调用的类对象的class
/// @param resourceName bundle资源名
+ (UIImage *)msy_getBundleImageWithName:(NSString *)imageName
                            bundleClass:(Class)bundleClass
                           resourceName:(NSString *)resourceName;

@end

NS_ASSUME_NONNULL_END
