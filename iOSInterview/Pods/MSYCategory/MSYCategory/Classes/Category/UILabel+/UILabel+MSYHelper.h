//
//  UILabel+MSYHelper.h
//
//
//  Created by SimonMiao on 2017/5/23.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MSYHelper)

+ (UILabel *)msy_labelWithTextColor:(UIColor *)color
                              font:(UIFont *)font;
+ (UILabel *)msy_labelWithTextColor:(UIColor *)color
                              font:(UIFont *)font
                              text:(NSString *)text;

@end
