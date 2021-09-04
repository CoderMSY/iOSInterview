//
//  UIButton+MSYHelper.m
//
//
//  Created by SimonMiao on 2017/5/24.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import "UIButton+MSYHelper.h"
#import "UIControl+MSYFixMultiClick.h"

@implementation UIButton (MSYHelper)

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                         titleFont:(UIFont *)font
                        titleColor:(UIColor *)color
                             title:(NSString *)title {
    UIButton *btn = [self msy_buttonWithTarget:target
                                        action:action
                                     titleFont:font
                                    titleColor:color
                                         title:title
                         isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                         titleFont:(UIFont *)font
                        titleColor:(UIColor *)color
                             title:(NSString *)title
             isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [self msy_buttonWithTarget:target
                                        action:action
                                         image:nil
                                     titleFont:font
                                    titleColor:color
                                         title:title
                         isAcceptEventInterval:isAcceptEventInterval];
    
    return btn;
}

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image  {
    UIButton *btn = [self msy_buttonWithTarget:target
                                        action:action
                                         image:image
                         isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image
             isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [self msy_buttonWithTarget:target
                                        action:action
                                         image:image
                                     titleFont:nil
                                    titleColor:nil
                                         title:nil
                         isAcceptEventInterval:isAcceptEventInterval];
    
    return btn;
}

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image
                         titleFont:(UIFont *)font
                        titleColor:(UIColor *)color
                             title:(NSString *)title {
    UIButton *btn = [self msy_buttonWithTarget:target
                                        action:action
                                         image:image
                                     titleFont:font
                                    titleColor:color
                                         title:title
                         isAcceptEventInterval:YES];
    return btn;
}

+ (UIButton *)msy_buttonWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image
                         titleFont:(UIFont *)font
                        titleColor:(UIColor *)color
                             title:(NSString *)title
             isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (action && target) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 设置图片
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if (color) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (font) {
        btn.titleLabel.font = font;
    }
     
    if (isAcceptEventInterval) {
        btn.msy_acceptEventInterval = 1.0;//!<默认防止重复点击时间为1.0秒
    }
    
    return btn;
}

@end
