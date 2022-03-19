//
//  MSYCommonTitleDetailFrameModel.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//static CGFloat const kCommonTDCell_titleLab_w = 65;//!<title的宽度
static CGFloat const kCommonTDCell_topMargin = 7.5;//!<距离上下的边距
static CGFloat const kCommonTDCell_margin = 15;//!<边距
//!
@interface MSYCommonTitleDetailFrameModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) BOOL isNeedSelectStyle;

@property (nonatomic, strong) UIFont *titleLabFont;
@property (nonatomic, strong) UIFont *detailLabFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *detailColor;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
