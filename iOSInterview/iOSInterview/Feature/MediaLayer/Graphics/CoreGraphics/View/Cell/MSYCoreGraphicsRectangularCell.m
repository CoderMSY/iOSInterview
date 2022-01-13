//
//  MSYCoreGraphicsRectangularCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/22.
//

#import "MSYCoreGraphicsRectangularCell.h"

@implementation MSYCoreGraphicsRectangularCell

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 线宽
    CGContextSetLineWidth(ctx, 2);
    // 矩形
    CGContextAddRect(ctx, CGRectMake(0, 0, 200, 200));
    // 设置颜色
    [[UIColor redColor]set];
    // 渲染
    CGContextStrokePath(ctx);
}


@end
