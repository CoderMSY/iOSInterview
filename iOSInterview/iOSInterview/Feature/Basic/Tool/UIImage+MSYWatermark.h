//
//  UIImage+MSYWatermark.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MSYWatermark)

+ (UIImage *)msy_imageWithColor:(UIColor * _Nonnull)color
                           size:(CGSize)size;

+ (UIImage *)msy_imageSynthesisWithImageList:(NSArray <UIImage *> *)imageList;

+ (UIImage *)msy_getWaterMarkImage:(UIImage * _Nonnull)originalImage
                             title:(NSString * _Nonnull)title
                          markFont:(UIFont * _Nullable)markFont
                         markColor:(UIColor * _Nullable)markColor;

@end

NS_ASSUME_NONNULL_END
