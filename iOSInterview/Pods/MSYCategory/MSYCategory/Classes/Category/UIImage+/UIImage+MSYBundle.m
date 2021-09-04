//
//  UIImage+MSYBundle.m
//  MBProgressHUD
//
//  Created by Simon Miao on 2021/4/22.
//

#import "UIImage+MSYBundle.h"

@implementation UIImage (MSYBundle)

+ (UIImage *)msy_getBundleImageWithName:(NSString *)imageName
                            bundleClass:(Class)bundleClass
                           resourceName:(NSString *)resourceName {
    //获取当前所在bundle
    NSBundle *currentBundle = [NSBundle bundleForClass:bundleClass];
    NSString *bundlePath = [currentBundle pathForResource:resourceName ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    //屏幕比例
    NSInteger scale = [UIScreen mainScreen].scale;
    //拼接图片名称
    imageName = [NSString stringWithFormat:@"%@@%zdx", imageName,scale];
    //路径
    NSString *imagePath = [resourceBundle pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

@end
