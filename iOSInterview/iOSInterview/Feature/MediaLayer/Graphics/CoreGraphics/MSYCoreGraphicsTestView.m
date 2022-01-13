//
//  MSYCoreGraphicsTestView.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/22.
//

#import "MSYCoreGraphicsTestView.h"

@implementation MSYCoreGraphicsTestView

#pragma mark - lifecycle methods

#pragma mark - public methods

- (void)drawRect:(CGRect)rect {
    [[UIColor orangeColor] setFill];
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把context压入栈中，并把context设置为当前绘图上下文
    UIGraphicsPushContext(ctx);
    
    [[UIColor blueColor] setFill];
    //将栈顶的上下文弹出，恢复先前的上下文，但是绘图状态不变
    UIGraphicsPopContext();
    
    UIRectFill(CGRectMake(100, 100, 100, 100)); //blue color
}

//- (void)drawRect:(CGRect)rect {
//    [[UIColor orangeColor] setFill];
//
//    //获取当前上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //保存context的状态
//    CGContextSaveGState(ctx);
//
//    [[UIColor blueColor] setFill];
//    //恢复保存context的状态
//    CGContextRestoreGState(ctx);
//
//    UIRectFill(CGRectMake(100, 100, 100, 100)); //orange color
//}

#pragma mark - private methods

#pragma mark - getter && setter

@end
