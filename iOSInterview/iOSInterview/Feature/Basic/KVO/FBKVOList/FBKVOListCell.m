//
//  FBKVOListCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "FBKVOListCell.h"
#import <MSYTableView/MSYCommonTableData.h>
#import <KVOController/KVOController.h>

@interface FBKVOListCell ()

@property (nonatomic, strong) FBKVOController *kvoCtrl;

@end

@implementation FBKVOListCell

#pragma mark - MSYTableViewCellProtocol
- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    self.textLabel.text = rowData.title;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    
    _kvoCtrl = [FBKVOController controllerWithObserver:self];
    
    [_kvoCtrl observe:rowData keyPath:NSStringFromSelector(@selector(title)) options:options action:@selector(numChange:)];
}

- (void)numChange:(NSDictionary<NSString *,id> * _Nonnull) change {
    NSString *newTitle = change[NSKeyValueChangeNewKey];
    self.textLabel.text = newTitle;
}
@end
