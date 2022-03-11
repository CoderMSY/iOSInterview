//
//  MSYOperationQueueHandleCell.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/17.
//

#import <MSYTableView/MSYBaseTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MSYOperationQueueHandleCell;
@protocol MSYOperationQueueHandleCellProtocol <NSObject>

- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell startBtnClicked:(UIButton *)sender;
- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell suspendBtnClicked:(UIButton *)sender;
- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell continueBtnClicked:(UIButton *)sender;
- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell cancelBtnClicked:(UIButton *)sender;

@end

@interface MSYOperationQueueHandleCell : MSYBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
