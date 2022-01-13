//
//  MSYOperationFooterView.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/17.
//

#import "MSYOperationFooterView.h"
#import <Masonry/Masonry.h>

@interface MSYOperationFooterView ()



@end

@implementation MSYOperationFooterView

#pragma mark - lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconIV];
        
        [self initConstraints];
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(300);
    }];
}

#pragma mark - getter && setter

- (UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
    }
    return _iconIV;
}

@end
