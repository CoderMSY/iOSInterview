//
//  UILabel+MSYHelper.m
//  
//
//  Created by SimonMiao on 2017/5/23.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import "UILabel+MSYHelper.h"

@implementation UILabel (MSYHelper)

+ (UILabel *)msy_labelWithTextColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *label = [self msy_labelWithTextColor:color font:font text:nil];
    return label;
}

+ (UILabel *)msy_labelWithTextColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    
    return label;
}

@end
