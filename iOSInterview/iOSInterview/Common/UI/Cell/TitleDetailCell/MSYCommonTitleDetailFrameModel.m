//
//  MSYCommonTitleDetailFrameModel.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import "MSYCommonTitleDetailFrameModel.h"

@implementation MSYCommonTitleDetailFrameModel

- (UIFont *)titleLabFont {
    if (!_titleLabFont) {
        _titleLabFont = [UIFont systemFontOfSize:15];
    }
    return _titleLabFont;
}

- (UIFont *)detailLabFont {
    if (!_detailLabFont) {
        _detailLabFont = [UIFont systemFontOfSize:13];
    }
    return _detailLabFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (UIColor *)detailColor {
    if (!_detailColor) {
        _detailColor = [UIColor grayColor];
    }
    return _detailColor;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
        CGFloat contentWidth = screen_w - kCommonTDCell_margin * 2;
        
        CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabFont} context:nil].size;
        _cellHeight = kCommonTDCell_topMargin + titleSize.height;
        
        CGSize detailSize = [self.detail boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.detailLabFont} context:nil].size;
        if (detailSize.height > 0) {
            _cellHeight += (detailSize.height + kCommonTDCell_topMargin);
        }
        
        _cellHeight += kCommonTDCell_topMargin;
        if (_cellHeight < 35) {
            _cellHeight = 35;
        }
        
    }
    return _cellHeight;
}


@end
