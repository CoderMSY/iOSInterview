//
//  YYAsyncLayer.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/4/11.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#if __has_include(<YYAsyncLayer/YYAsyncLayer.h>)
FOUNDATION_EXPORT double YYAsyncLayerVersionNumber;
FOUNDATION_EXPORT const unsigned char YYAsyncLayerVersionString[];
#import <YYAsyncLayer/YYSentinel.h>
#import <YYAsyncLayer/YYTransaction.h>
#else
#import "YYSentinel.h"
#import "YYTransaction.h"
#endif

@class YYAsyncLayerDisplayTask;

NS_ASSUME_NONNULL_BEGIN

/**
 The YYAsyncLayer class is a subclass of CALayer used for render contents asynchronously.
 
 YYAsyncLayer为了异步绘制而继承CALayer的子类。通过使用CoreGraphic相关方法，在子线程中绘制内容Context，绘制完成后，回到主线程对layer.contents进行直接显示。
 YYAsyncLayer是通过创建异步创建图像Context在其绘制，最后再主线程异步添加图像从而实现的异步绘制。同时，在绘制过程中进行了多次进行取消判断，以避免额外绘制.
  
 @discussion When the layer need update it's contents, it will ask the delegate 
 for a async display task to render the contents in a background queue.
 */
@interface YYAsyncLayer : CALayer
/// Whether the render code is executed in background. Default is YES.
@property BOOL displaysAsynchronously;
@end


/**
 The YYAsyncLayer's delegate protocol. The delegate of the YYAsyncLayer (typically a UIView)
 must implements the method in this protocol.
 YYAsyncLayerDelegate 的 newAsyncDisplayTask 是提供了 YYAsyncLayer 需要在后台队列绘制的内容
 */
@protocol YYAsyncLayerDelegate <NSObject>
@required
/// This method is called to return a new display task when the layer's contents need update.
/// 提供了 YYAsyncLayer 需要在后台队列绘制的内容
- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end


/**
 A display task used by YYAsyncLayer to render the contents in background queue.
 display 在main thread或者background thread调用 这要求 display 应该是线程安全的
 willdisplay 和 didDisplay 在 mainthread 调用。
 */
@interface YYAsyncLayerDisplayTask : NSObject

/**
 This block will be called before the asynchronous drawing begins.
 It will be called on the main thread.
 
 block param layer:  The layer.
 */
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);

/**
 This block is called to draw the layer's contents.
 
 @discussion This block may be called on main thread or background thread,
 so is should be thread-safe.
 
 block param context:      A new bitmap content created by layer.
 block param size:         The content size (typically same as layer's bound size).
 block param isCancelled:  If this block returns `YES`, the method should cancel the
   drawing process and return as quickly as possible.
 */
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));

/**
 This block will be called after the asynchronous drawing finished.
 It will be called on the main thread.
 
 block param layer:  The layer.
 block param finished:  If the draw process is cancelled, it's `NO`, otherwise it's `YES`.
 */
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);

@end

NS_ASSUME_NONNULL_END
