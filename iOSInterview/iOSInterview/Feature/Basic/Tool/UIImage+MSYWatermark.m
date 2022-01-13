//
//  UIImage+MSYWatermark.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "UIImage+MSYWatermark.h"

#define HORIZONTAL_SPACE 30//水平间距
#define VERTICAL_SPACE 50//竖直间距
#define CG_TRANSFORM_ROTATION (M_PI_2 / 3)//旋转角度(正旋45度 || 反旋45度)

@implementation UIImage (MSYWatermark)

+ (UIImage *)msy_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)msy_imageSynthesisWithImageList:(NSArray <UIImage *> *)imageList {
    if (!imageList) {
        return nil;
    }
    CGFloat image_maxW = 0;
    CGFloat image_sumH = 0;
    for (UIImage *image in imageList) {
        if (image.size.width > image_maxW) {
            image_maxW = image.size.width;
        }
        
        image_sumH += image.size.height;
    }
    UIGraphicsBeginImageContext(CGSizeMake(image_maxW, image_sumH));
    
    CGFloat current_x = 0;
    CGFloat current_y = 0;
    for (UIImage *image in imageList) {
        if (image.size.width < image_maxW) {
            current_x = (image_maxW - image.size.width) / 2;
        }
        else {
            current_x = 0;
        }
        [image drawInRect:CGRectMake(current_x,
                                     current_y,
                                     image.size.width,
                                     image.size.height)];
        current_y += image.size.height;
    }
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 根据目标图片制作一个盖水印的图片
 
 @param originalImage 源图片
 @param title 水印文字
 @param markFont 水印文字font(如果不传默认为23)
 @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
 @return 返回盖水印的图片
 */
+ (UIImage *)msy_getWaterMarkImage:(UIImage *)originalImage
                             title:(NSString *)title
                          markFont:(UIFont *)markFont
                         markColor:(UIColor *)markColor {
    
    UIFont *font = markFont;
    if (font == nil) {
        font = [UIFont systemFontOfSize:23];
    }
    UIColor *color = markColor;
    if (color == nil) {
        color = [self mostColor:originalImage];
    }
    //原始image的宽高
    CGFloat viewWidth = originalImage.size.width;
    CGFloat viewHeight = originalImage.size.height;
    //为了防止图片失真，绘制区域宽高和原始图片宽高一样
    UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));
    //先将原始image绘制上
    [originalImage drawInRect:CGRectMake(0, 0, viewWidth, viewHeight)];
    //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
    NSDictionary *attrDic = @{
        NSFontAttributeName : font,
        NSForegroundColorAttributeName : color,
    };
    NSString *mark = title;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attrDic];
    //绘制文字的宽高
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;
    
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth / 2, viewHeight / 2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(-CG_TRANSFORM_ROTATION));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth / 2, -viewHeight / 2));
    
    //计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength - viewWidth) / 2;
    CGFloat orignY = -(sqrtLength - viewHeight) / 2;
    
    //在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attrDic];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + VERTICAL_SPACE);
        }
        else {
            tempOrignX += (strWidth + HORIZONTAL_SPACE);
        }
    }
    //根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return finalImg;
}

//+ (UIImage *)msy_getCircleImage:(UIImage *)originalImage {
//    if (!originalImage) {
//        return nil;
//    }
//    CGFloat original_w = originalImage.size.width;
//    CGFloat original_h = originalImage.size.height;
//    UIGraphicsBeginImageContext(CGSizeMake(original_w, original_h));
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddArc(<#CGContextRef  _Nullable c#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>)
////    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
////    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//}
#pragma mark - lifecycle methods

#pragma mark - public methods


#pragma mark - private methods


/// 根据图片获取图片的主色调
+ (UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
//第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
 
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

@end
