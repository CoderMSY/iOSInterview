//
//  MSYBaseListViewController.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYBaseViewController.h"
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYBaseListViewController : MSYBaseViewController

@property (nonatomic, strong) MSYCommonTableView *listView;

- (void)pushNextPageWithCtr:(UIViewController *)ctr
                      title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
