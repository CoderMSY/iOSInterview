//
//  MSYCoreGraphicsLineView.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/22.
//

#import "MSYCoreGraphicsLineView.h"

@implementation MSYCoreGraphicsLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    switch (self.drawType) {
        case MSYCGDrawType_line_mutPathRef:
            [self drawLineByCGMutablePathRef];
            break;
        case MSYCGDrawType_line:
            [self drawLineByCGContextMoveToPoint];
            break;
        case MSYCGDrawType_rect:
            [self drawRectangular];
            break;
        case MSYCGDrawType_circle:
            [self drawCircle];
            break;
        case MSYCGDrawType_ellipse:
            [self drawEllipse];
            break;
        case MSYCGDrawType_curve:
            [self drawCurve];
            break;
        case MSYCGDrawType_text:
            [self drawText];
            break;
        case MSYCGDrawType_image:
            [self drawImage];
            break;
        case MSYCGDrawType_watermark:
            [self drawWatermark];
        default:
            
            break;
    }
}



#pragma mark - CGMutablePathRef画线（最原始的绘图方式）

- (void)drawLineByCGMutablePathRef {
    // 1.获取图形上下文
    // 目前我们所用的上下文都是以UIGraphics
    // CGContextRef Ref：引用 CG:目前使用到的类型和函数 一般都是CG开头 CoreGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.描述路径
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 设置起点
    // path：给哪个路径设置起点
    CGPathMoveToPoint(path, NULL, 50, 50);
    
    // 添加一根线到某个点
    CGPathAddLineToPoint(path, NULL, 150, 150);
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path);
    
    // 4.渲染上下文
    CGContextStrokePath(ctx);
    
    CGPathRelease(path);
}

#pragma mark - CGContextMoveToPoint画线 CGContextSet...设置属性

- (void)drawLineByCGContextMoveToPoint {
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 描述路径
    // 添加到上下文
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 50);
    // 设置起点
    CGContextMoveToPoint(ctx, 80, 60);
    // 默认下一根线的起点就是上一根线终点
    CGContextAddLineToPoint(ctx, 100, 150);
    // 设置绘图状态,一定要在渲染之前
    // 颜色
    [[UIColor redColor] setStroke];
    // 线宽
    CGContextSetLineWidth(ctx, 5);
    // 设置连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    // 设置顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 渲染上下文
    CGContextStrokePath(ctx);
}

#pragma mark - 画矩形

- (void)drawRectangular {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 线宽
    CGContextSetLineWidth(ctx, 10);
    // 矩形
    CGContextAddRect(ctx, CGRectMake(20, 20, 250, 100));
    // 设置颜色
    [[UIColor blueColor] setStroke];
    // 渲染
    CGContextStrokePath(ctx);
}

- (void)drawCircle {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 20, 100, 100));
    CGContextStrokePath(ctx);
}

- (void)drawEllipse {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 20, 150, 100));
    CGContextStrokePath(ctx);
}

// 如何绘制曲线
- (void)drawCurve {
    // 原生绘制方法
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 描述路径
    // 设置起点
    CGContextMoveToPoint(ctx, 50, 100);
    // cpx:控制点的x
//    CG_EXTERN void CGContextAddQuadCurveToPoint(CGContextRef cg_nullable c,
//                                                CGFloat cpx, CGFloat cpy, CGFloat x, CGFloat y)
    CGContextAddQuadCurveToPoint(ctx, 150, 30, 250, 100);
    // 渲染上下文
    CGContextStrokePath(ctx);
}

- (void)drawText {
    NSString *str = @"画字符串";
    
    [str drawInRect:CGRectMake(50, 50, 100, 50) withAttributes:@{
        NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName : [UIColor redColor],
    }];
}

- (void)drawImage {
    UIImage *image = [UIImage imageNamed:@"avatar_female_medium"];
    [image drawInRect:CGRectMake(50, 50, 100, 100)];
}

- (void)drawWatermark {
    UIImage *image = [UIImage imageNamed:@"avatar_female_medium"];
    [image drawInRect:CGRectMake(25, 25, 100, 100)];
    
    NSString *str = @"添加水印";
    [str drawInRect:CGRectMake(100, 75, 80, 20) withAttributes:nil];
}

//- (void)radiousRect
//{
//    // 圆角矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 250, 100) cornerRadius:30];
//    path.lineWidth = 10;
//    [[UIColor redColor] setStroke];
//    [path stroke];
//}

/*
- (void)drawCircle
{
    // 圆弧
    // Center：圆心
    // startAngle:弧度
    // clockwise:YES:顺时针 NO：逆时针
    // 扇形
    CGPoint center = CGPointMake(100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:60 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    // 添加一根线到圆心
    [path addLineToPoint:center];
    
    // 封闭路径，关闭路径：从路径的终点到起点
    [path closePath];
    
    path.lineWidth = 3;
    [[UIColor redColor] set];
    [path stroke];
    
    [[UIColor greenColor] setFill];
    // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
    [path fill];
}
 */

//- (void)drawUIBezierPathState
//{
//    UIBezierPath *path = [UIBezierPath bezierPath];
//
//    [path moveToPoint:CGPointMake(50, 50)];
//
//    [path addLineToPoint:CGPointMake(100, 100)];
//
//    // 设置状态
//    path.lineWidth = 10;
//    [[UIColor redColor] set];
//    // 绘制
//    [path stroke];
//
//    UIBezierPath *path1 = [UIBezierPath bezierPath];
//    [path1 moveToPoint:CGPointMake(100, 50)];
//    [path1 addLineToPoint:CGPointMake(150, 150)];
//    // 设置状态
//    path1.lineWidth = 3;
//    [[UIColor greenColor] set];
//
//    path1.lineJoinStyle = kCGLineJoinBevel;
//
//    [path1 stroke];
//}

//- (void)drawLineByBezierPath {
//    // UIKit已经封装了一些绘图的功能
//    // 贝瑟尔路径
//    // 创建路径
//    UIBezierPath *path = [UIBezierPath bezierPath];
//
//    // 设置起点
//    [path moveToPoint:CGPointMake(90, 50)];
//
//    // 添加一根线到某个点
//    [path addLineToPoint:CGPointMake(150, 150)];
//
//    // 绘制路径
//    [path stroke];
//}
@end
