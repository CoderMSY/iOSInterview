//
//  MSYCommonTitleImageFrameModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import "MSYCommonTitleImageFrameModel.h"

@implementation MSYCommonTitleImageFrameModel

- (UIFont *)titleLabFont {
    if (!_titleLabFont) {
        _titleLabFont = [UIFont systemFontOfSize:15];
    }
    return _titleLabFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (image) {
        CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
        CGFloat contentW = screen_w - kCommonTICell_margin * 2;
        
        CGFloat contentH = contentW * image.size.height / image.size.width;
        
        _cellHeight += contentH;
    }
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
        CGFloat contentWidth = screen_w - kCommonTICell_margin * 2;
        
        CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabFont} context:nil].size;
        _cellHeight = kCommonTICell_topMargin + titleSize.height;
        
        _cellHeight += kCommonTICell_topMargin * 2;
        
    }
    return _cellHeight;
}

@end
