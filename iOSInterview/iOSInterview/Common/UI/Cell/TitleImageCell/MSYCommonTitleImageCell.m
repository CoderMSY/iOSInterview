//
//  MSYCommonTitleImageCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import "MSYCommonTitleImageCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UILabel+MSYHelper.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYCommonTitleImageFrameModel.h"

@interface MSYCommonTitleImageCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *iconIV;

@end

@implementation MSYCommonTitleImageCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.iconIV];
        
        [self initConstraints];
    }
    
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(kCommonTICell_topMargin);
        make.leading.mas_equalTo(self.contentView).offset(kCommonTICell_margin);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-kCommonTICell_margin);
    }];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(kCommonTICell_topMargin);
        make.leading.mas_equalTo(self.contentView).offset(kCommonTICell_margin);
        make.bottom.mas_equalTo(self.contentView).offset(-kCommonTICell_topMargin);
        make.trailing.mas_equalTo(self.contentView).offset(-kCommonTICell_margin);
    }];
}

#pragma mark - MSYTableViewCellProtocol

- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    if ([rowData.extraInfo isKindOfClass:[MSYCommonTitleImageFrameModel class]]) {
        MSYCommonTitleImageFrameModel *fModel = (MSYCommonTitleImageFrameModel *)rowData.extraInfo;
        
        self.titleLab.text = fModel.title;
        self.titleLab.font = fModel.titleLabFont;
        self.titleLab.textColor = fModel.titleColor;
        self.iconIV.image = fModel.image;
    }
}

#pragma mark - getter && setter

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel msy_labelWithTextColor:[UIColor blackColor] font:nil];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
    }
    return _iconIV;
}



@end
