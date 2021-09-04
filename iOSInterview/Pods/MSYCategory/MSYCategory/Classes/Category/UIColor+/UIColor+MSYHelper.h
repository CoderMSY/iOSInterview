//
//  UIColor+MSYHelper.h
//  
//
//  Created by SimonMiao on 16/9/27.
//  Copyright © 2016年 yongrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MSYHelper)


/**
 设置十六进制颜色和透明度

 @param hexValue 十六进制值
 @param alphaValue 透明度
 @return 颜色
 */
+ (UIColor *)msy_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)msy_colorWithHex:(NSInteger)hexValue;


/// 设置十六进制颜色和透明度
/// @param hexValue 字符串格式的十六进制值
/// @param alphaValue 透明度
+ (UIColor *)msy_colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alphaValue;

/// 设置十六进制颜色和透明度
/// @param hexValue 字符串格式的十六进制值
+ (UIColor *)msy_colorWithHexString:(NSString *)hexValue;

+ (UIColor *)msy_colorWithWhite:(NSInteger)white;
+ (UIColor *)msy_colorWithWhite:(NSInteger)white alpha:(CGFloat)alpha;

/**
 设置RGB颜色

 @param red 红
 @param green 绿
 @param blue 蓝
 @param alpha 透明度
 */
+ (UIColor *)msy_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue
                       alpha:(CGFloat)alpha;

+ (UIColor *)msy_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue;

#pragma mark - 主题颜色
/** 主题--蓝色 */
//+ (UIColor *)msy_themeBlueColor;
//+ (UIColor *)msy_themeGreenColor;
//+ (UIColor *)msy_themeYellowColor;
//+ (UIColor *)msy_themeRedColor;
//+ (UIColor *)msy_themeGrayColor;
#pragma mark - 背景颜色

+ (UIColor *)msy_bgColor;

//+ (UIColor *)msy_bgLightGrayColor;
///** 背景--灰色 */
//+ (UIColor *)msy_bgGrayColor;
//
///** 背景--日期 灰色 */
//+ (UIColor *)msy_bgDateGrayColor;
///** 背景--搜索 灰色 */
//+ (UIColor *)msy_bgSeachGrayColor;

#pragma mark - line color

+ (UIColor *)msy_lineColor;

#pragma mark - 字体颜色
/** 字体--黑色 */
//+ (UIColor *)msy_fontBlackColor;//标题、正文
///** 字体--深灰色 */
//+ (UIColor *)msy_fontDarkGrayColor;//辅助内容、提示文案、按钮置灰
///** 字体--深浅色 */
//+ (UIColor *)msy_fontLightGrayColor;
///** 字体--深蓝色 */
//+ (UIColor *)msy_fontDeepBlueColor;
//+ (UIColor *)msy_fontOrangeColor;//选中状态
//+ (UIColor *)msy_fontBlueColor;
//+ (UIColor *)msy_fontGreenColor;

#pragma mark - iOS系统默认颜色

/**
 tableView头部尾部视图背景颜色
 */
+ (UIColor *)msy_tableViewHeaderViewBgColor;

@end
