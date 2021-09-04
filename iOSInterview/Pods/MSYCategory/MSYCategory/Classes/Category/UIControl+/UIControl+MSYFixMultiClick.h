//
//  UIControl+MSYFixMultiClick.h
//  
//
//  Created by SimonMiao on 2018/6/25.
//  Copyright © 2018年 avatar. All rights reserved.
//  Runtime防止多次点击

#import <UIKit/UIKit.h>

@interface UIControl (MSYFixMultiClick)

@property (nonatomic, assign) NSTimeInterval msy_acceptEventInterval; // 重复点击的间隔

@end
