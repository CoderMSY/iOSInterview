//
//  MSYKVOListCell.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "MSYKVOListCell.h"
#import <MSYTableView/MSYCommonTableData.h>
#import "NSObject+WMSafeKVO.h"

@interface MSYKVOListCell ()

@property (nonatomic, strong) MSYCommonTableRow *rowData;

@end

@implementation MSYKVOListCell

#pragma mark - MSYTableViewCellProtocol
- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    _rowData = rowData;
    self.textLabel.text = rowData.title;
    id value = [rowData valueForKeyPath:NSStringFromSelector(@selector(title))];
    
    //https://blog.csdn.net/weixin_34004750/article/details/91633037?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~aggregatepage~first_rank_ecpm_v1~rank_v31_ecpm-1-91633037.pc_agg_new_rank&utm_term=%E5%A6%82%E4%BD%95%E5%88%A4%E6%96%ADKVO%E5%B7%B2%E7%BB%8F%E6%B7%BB%E5%8A%A0&spm=1000.2123.3001.4430
    NSLog(@"value:%@", value);
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [rowData addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:options context:nil];
    [rowData wm_addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:options context:nil];
    id addValue = [rowData valueForKeyPath:NSStringFromSelector(@selector(title))];
    NSLog(@"addValue:%@", addValue);
}

- (void)dealloc {
    if (_rowData) {
        [_rowData wm_removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
//        [_rowData removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSString *newTitle = change[NSKeyValueChangeNewKey];
    self.textLabel.text = newTitle;
}

@end
