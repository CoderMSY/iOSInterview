//
//  MSYCommonTitleImageFrameModel.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static CGFloat const kCommonTICell_topMargin = 7.5;//!<距离上下的边距
static CGFloat const kCommonTICell_margin = 15;//!<边距

@interface MSYCommonTitleImageFrameModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIFont *titleLabFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
