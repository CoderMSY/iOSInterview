//
//  UIButton+MSYHelper.h
//  
//
//  Created by SimonMiao on 2017/5/24.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MSYHelper)

+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                         titleFont:(UIFont * _Nullable)font
                        titleColor:(UIColor * _Nullable)color
                             title:(NSString * _Nullable)title;
/**
 初始化按钮

 @param target 点击事件的响应者
 @param action 按钮点击方法
 @param font 按钮标题字号
 @param color 按钮标题颜色
 @param title 按钮标题大小
 @param isAcceptEventInterval 是否接受事件点击间隔
 @return 按钮对象
 */
+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                         titleFont:(UIFont * _Nullable)font
                        titleColor:(UIColor * _Nullable)color
                             title:(NSString * _Nullable)title
             isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                             image:(UIImage * _Nullable)image;

+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                             image:(UIImage * _Nullable)image
             isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                             image:(UIImage * _Nullable)image
                         titleFont:(UIFont * _Nullable)font
                        titleColor:(UIColor * _Nullable)color
                             title:(NSString * _Nullable)title;

/// 快速初始化按钮方法
/// @param target 事件接收对象
/// @param action 点击事件方法
/// @param image 图片
/// @param font 字体
/// @param color 颜色
/// @param title 标题
/// @param isAcceptEventInterval 是否接受事件间隔
+ (UIButton *)msy_buttonWithTarget:(id _Nullable)target
                            action:(SEL _Nullable)action
                             image:(UIImage * _Nullable)image
                         titleFont:(UIFont * _Nullable)font
                        titleColor:(UIColor * _Nullable)color
                             title:(NSString * _Nullable)title
             isAcceptEventInterval:(BOOL)isAcceptEventInterval;

@end

NS_ASSUME_NONNULL_END
