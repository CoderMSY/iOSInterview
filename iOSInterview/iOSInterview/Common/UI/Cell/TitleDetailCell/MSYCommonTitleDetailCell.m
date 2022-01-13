//
//  MSYCommonTitleDetailCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import "MSYCommonTitleDetailCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UILabel+MSYHelper.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYCommonTitleDetailFrameModel.h"

@interface MSYCommonTitleDetailCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;

@end

@implementation MSYCommonTitleDetailCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailLab];
        
        [self initConstraints];
    }
    
    return self;
}

#pragma mark - private methods

- (void)initConstraints {
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(kCommonTDCell_topMargin);
        make.leading.mas_equalTo(self.contentView).offset(kCommonTDCell_margin);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-kCommonTDCell_margin);
    }];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(kCommonTDCell_topMargin);
        make.leading.mas_equalTo(self.contentView).offset(kCommonTDCell_margin);
        make.bottom.mas_lessThanOrEqualTo(self.contentView);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-kCommonTDCell_margin);
    }];
}

#pragma mark - MSYTableViewCellProtocol

- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    if ([rowData.extraInfo isKindOfClass:[MSYCommonTitleDetailFrameModel class]]) {
        MSYCommonTitleDetailFrameModel *fModel = (MSYCommonTitleDetailFrameModel *)rowData.extraInfo;
        
        self.titleLab.text = fModel.title;
        self.titleLab.font = fModel.titleLabFont;
        self.detailLab.text = fModel.detail;
        self.detailLab.font = fModel.detailLabFont;
        
        self.titleLab.textColor = fModel.titleColor;
        self.detailLab.textColor = fModel.detailColor;
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

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [UILabel msy_labelWithTextColor:[UIColor grayColor] font:nil];
        _detailLab.numberOfLines = 0;
    }
    return _detailLab;
}


@end
