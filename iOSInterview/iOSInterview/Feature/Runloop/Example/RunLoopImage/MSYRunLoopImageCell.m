//
//  MSYRunLoopImageCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/21.
//

#import "MSYRunLoopImageCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UILabel+MSYHelper.h>
#import <MSYTableView/MSYCommonTableData.h>

@interface MSYRunLoopImageCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatarIV;

@end

@implementation MSYRunLoopImageCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.avatarIV];
        
        [self initConstraints];
    }
    
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.avatarIV.mas_trailing).offset(15);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-15);
    }];
}

//- (void)setAvatarImage:(UIImage *)image {
//    self.avatarIV.image = image;
//    NSLog(@"%@", [NSThread currentThread]);
//}

#pragma mark - MSYTableViewCellProtocol

- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
//    if (tableView.isDragging == NO && tableView.isDecelerating == NO) {
//        //
//    }
    
//    if (tableView.isDecelerating == YES) {
//        self.avatarIV.image = [UIImage imageNamed:rowData.detailTitle];
//        self.nameLabel.text = rowData.title;
//    }
//    else {
//        self.nameLabel.text = rowData.title;
//        [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:rowData.detailTitle] afterDelay:0.25 inModes:@[NSDefaultRunLoopMode]];
//    }
    
    self.nameLabel.text = rowData.title;
    self.avatarIV.image = [UIImage imageNamed:rowData.detailTitle];
    
    
}

#pragma mark - getter && setter

- (UIImageView *)avatarIV {
    if (!_avatarIV) {
        _avatarIV = [[UIImageView alloc] init];
    }
    return _avatarIV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel msy_labelWithTextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:6.0]];
//        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

@end
