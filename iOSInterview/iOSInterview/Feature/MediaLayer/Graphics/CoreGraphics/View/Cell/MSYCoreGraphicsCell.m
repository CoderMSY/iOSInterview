//
//  MSYCoreGraphicsLineCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/22.
//

#import "MSYCoreGraphicsCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UILabel+MSYHelper.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYCoreGraphicsLineView.h"

@interface MSYCoreGraphicsCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *separatorLineView;
@property (nonatomic, strong) MSYCoreGraphicsLineView *lineView;

@end

@implementation MSYCoreGraphicsCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.separatorLineView];
        [self.contentView addSubview:self.lineView];
        
        [self initConstraints];
    }
    
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(3);
        make.leading.mas_equalTo(self.contentView).offset(15);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
        make.leading.mas_equalTo(self.contentView).offset(15);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-15);
    }];
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLabel.mas_bottom).offset(3);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1.0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorLineView.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
    }];
}

#pragma mark - MSYTableViewCellProtocol

- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    if ([rowData.extraInfo isKindOfClass:[NSNumber class]]) {
        NSNumber *typeNum = rowData.extraInfo;
        
        self.titleLabel.text = rowData.title;
        self.detailLabel.text = rowData.detailTitle;
        self.lineView.drawType = typeNum.integerValue;
        [self.lineView setNeedsDisplay];
    }
}

#pragma mark - getter && setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel msy_labelWithTextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel msy_labelWithTextColor:[UIColor grayColor] font:[UIFont systemFontOfSize:12]];
    }
    return _detailLabel;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
        _separatorLineView.backgroundColor = [UIColor orangeColor];
    }
    return _separatorLineView;
}

- (MSYCoreGraphicsLineView *)lineView {
    if (!_lineView) {
        _lineView = [[MSYCoreGraphicsLineView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

@end
