//
//  MSYCollectionItemCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/10/15.
//

#import "MSYCollectionItemCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UILabel+MSYHelper.h>

@interface MSYCollectionItemCell ()

@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation MSYCollectionItemCell

#pragma mark - lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        [self.contentView addSubview:self.nameLab];
        
        [self initConstraints];
    }
    return self;
}

#pragma mark - public methods

+ (NSString *)cellReuseId {
    return NSStringFromClass([self class]);
}

- (void)setName:(NSString *)name {
    _name = name;
    
    self.nameLab.text = name;
}

#pragma mark - private methods

- (void)initConstraints {
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(40);
    }];
}

#pragma mark - getter && setter

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel msy_labelWithTextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    }
    return _nameLab;
}

@end
