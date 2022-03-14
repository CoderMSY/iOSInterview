//
//  MSYBaseListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYBaseListViewController.h"
#import <Masonry/Masonry.h>

@interface MSYBaseListViewController ()

@end

@implementation MSYBaseListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.listView];
    [self initConstraints];
}

#pragma mark - public methods

- (void)pushNextPageWithCtr:(UIViewController *)ctr
                      title:(NSString *)title {
    if (!ctr) {
        return;
    }
    
    ctr.title = title;
    
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}


@end
