//
//  MSYOperationQueueHandleCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/17.
//

#import "MSYOperationQueueHandleCell.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UIButton+MSYHelper.h>
#import <MSYTableView/UIView+MSYKit.h>

@interface MSYOperationQueueHandleCell ()

@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation MSYOperationQueueHandleCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *titleList = @[
            @"start",
            @"suspend",
            @"continue",
            @"cancel"
        ];
        for (NSString *title in titleList) {
            NSInteger i = [titleList indexOfObject:title];
            UIButton *btn = [UIButton msy_buttonWithTarget:self action:@selector(btnClicked:) titleFont:[UIFont systemFontOfSize:13] titleColor:[UIColor blueColor] title:title];
            btn.tag = 10000 + i;
            btn.layer.cornerRadius = 5.0;
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = [UIColor blueColor].CGColor;
            [self.contentView addSubview:btn];
            
            [self.btnList addObject:btn];
        }
        
        [self initConstraints];
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.btnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:15 tailSpacing:15];
    [self.btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(35);
    }];
}

- (void)btnClicked:(UIButton *)sender {
    NSInteger index = sender.tag - 10000;
    
    UIViewController *ctr = [self msy_viewController];
    switch (index) {
        case 0:
            if ([ctr respondsToSelector:@selector(operationQueueHandleCell:startBtnClicked:)]) {
                [(id<MSYOperationQueueHandleCellProtocol>)ctr operationQueueHandleCell:self startBtnClicked:sender];
            }
            break;
        case 1:
            if ([ctr respondsToSelector:@selector(operationQueueHandleCell:startBtnClicked:)]) {
                [(id<MSYOperationQueueHandleCellProtocol>)ctr operationQueueHandleCell:self suspendBtnClicked:sender];
            }
            break;
        case 2:
            if ([ctr respondsToSelector:@selector(operationQueueHandleCell:startBtnClicked:)]) {
                [(id<MSYOperationQueueHandleCellProtocol>)ctr operationQueueHandleCell:self continueBtnClicked:sender];
            }
            break;
        case 3:
            if ([ctr respondsToSelector:@selector(operationQueueHandleCell:startBtnClicked:)]) {
                [(id<MSYOperationQueueHandleCellProtocol>)ctr operationQueueHandleCell:self cancelBtnClicked:sender];
            }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - getter && setter

- (NSMutableArray *)btnList {
    if (!_btnList) {
        _btnList = [NSMutableArray array];
    }
    return _btnList;
}

@end
