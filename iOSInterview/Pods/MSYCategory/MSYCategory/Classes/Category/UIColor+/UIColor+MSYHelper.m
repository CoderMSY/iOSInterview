//
//  UIColor+MSYHelper.m
//  AVWork
//
//  Created by SimonMiao on 16/9/27.
//  Copyright © 2016年 yongrun. All rights reserved.
//

#import "UIColor+MSYHelper.h"

@implementation UIColor (MSYHelper)

+ (UIColor *)msy_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)msy_colorWithHex:(NSInteger)hexValue
{
    return [UIColor msy_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)msy_colorWithHexString:(NSString *)hexValue {
    return [UIColor msy_colorWithHexString:hexValue alpha:1.0];
}

+ (UIColor *)msy_colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alphaValue {
    NSString * cString = [[hexValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString * rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString * gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString * bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:alphaValue];
}

+ (UIColor *)msy_colorWithWhite:(NSInteger)white {
    return [UIColor msy_colorWithWhite:white alpha:1.0];
}

+ (UIColor *)msy_colorWithWhite:(NSInteger)white alpha:(CGFloat)alpha {
    return [UIColor colorWithWhite:white / 255.0 alpha:alpha];
}

+ (UIColor *)msy_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [self msy_colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)msy_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue: blue / 255.0 alpha:alpha];
}

#pragma mark - 主题颜色
//+ (UIColor *)msy_themeBlueColor {
//    return [UIColor msy_colorWithHex:0x0099ff];
//}
//
//+ (UIColor *)msy_themeGreenColor {
//    return [UIColor msy_colorWithHex:0x22c064];
//}
//
//+ (UIColor *)msy_themeOrangeColor {
//    return [UIColor msy_colorWithHex:0xf6540c];
//}
//
//+ (UIColor *)msy_themeYellowColor {
//    return [UIColor msy_colorWithHex:0xF9B571];
//}
//
//+ (UIColor *)msy_themeRedColor {
//    return [UIColor msy_colorWithHex:0xf84545];
//}
//
//+ (UIColor *)msy_themeGrayColor {
//    return [UIColor colorWithWhite:143.0 / 255.0 alpha:1.0];
//}

#pragma mark - 背景颜色

+ (UIColor *)msy_bgColor {
    return [UIColor msy_colorWithRed:239 green:239 blue:239];
}

//+ (UIColor *)msy_bgLightGrayColor {
//    return [UIColor msy_colorWithHex:0xefeff4];
//}
//
//+ (UIColor *)msy_bgGrayColor {
//    return [UIColor msy_colorWithHex:0xf2f2f2];
//}
//
//+ (UIColor *)msy_bgDateGrayColor {
//    return [UIColor msy_colorWithHex:0xd9d9d9];
//}
//
//+ (UIColor *)msy_bgSeachGrayColor {
//    return [UIColor msy_colorWithHex:0xe6e6e6];
//}

#pragma mark - line color

+ (UIColor *)msy_lineColor {
    return [UIColor msy_colorWithRed:200 green:200 blue:200];
}

#pragma mark - 字体颜色

+ (UIColor *)msy_fontBlackColor {
    return [UIColor msy_colorWithHex:0x2b2b2b];
}

+ (UIColor *)msy_fontDarkGrayColor {
    return [UIColor msy_colorWithHex:0x808080];
}

+ (UIColor *)msy_fontLightGrayColor {
    return [UIColor msy_colorWithHex:0xb3b3b3];
}

+ (UIColor *)msy_fontDeepBlueColor {
    return [UIColor msy_colorWithHex:0x5277ff];
}

+ (UIColor *)msy_fontOrangeColor {
    return [UIColor msy_colorWithHex:0xf6540c];
}

+ (UIColor *)msy_fontBlueColor {
    return [UIColor msy_colorWithHex:0x0099ff];
}

+ (UIColor *)msy_fontGreenColor {
    return [UIColor msy_colorWithHex:0x23d28a];
}

//
//+ (UIColor *)msy_blueColor {
//    return [UIColor msy_colorWithHex:0x0199FF];//0x0099ff
//}
//
//+ (UIColor *)msy_lavenderColor {
//    return [UIColor msy_colorWithHex:0xcde1ff];
//}
//
//+ (UIColor *)msy_ghostWhiteColor {
//    return [UIColor msy_colorWithHex:0xf1f7ff];
//}
//
//+ (UIColor *)msy_goldColor {
//    return [UIColor msy_colorWithHex:0xffb86c];
//}
//
//+ (UIColor *)msy_redColor {
//    return [UIColor msy_colorWithHex:0xff6c6c];
//}
//
//+ (UIColor *)msy_greenColor {
//    return [UIColor msy_colorWithHex:0x22C064];
//}

#pragma mark - iOS系统默认颜色

+ (UIColor *)msy_tableViewHeaderViewBgColor {
    return [UIColor msy_colorWithHex:0xf7f7f7];
}

@end
