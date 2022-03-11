//
//  MSYRunLoopImageViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/21.
//

#import "MSYRunLoopImageViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
//#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>
#import "YYFPSLabel.h"

#import "MSYRunLoopImageCell.h"

@interface MSYRunLoopImageViewController () <MSYCommonTableViewDelegate>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) NSMutableArray *sectionModelList;

@end

@implementation MSYRunLoopImageViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self loadDataSourceWithPageIndex:0];
    
//    [self.view addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSourceWithPageIndex:(NSInteger)pageIndex {
    if (pageIndex == 0 && _sectionModelList.count > 0) {
        [_sectionModelList removeAllObjects];
    }
    NSMutableArray *rowDicArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 100000; i++) {
        NSString *avatar = i % 2 == 0 ? @"avatar_male_large" : @"avatar_female_large";
        NSDictionary *rowDic = @{
            kRow_title : [NSString stringWithFormat:@"%ld", i],
            kRow_detailTitle : avatar,
            kRow_cellClass : NSStringFromClass([MSYRunLoopImageCell class]),
            kRow_rowHeight : @(10),
        };
        [rowDicArr addObject:rowDic];
    }
    
    NSString *headerTitle = [NSString stringWithFormat:@"第%ld组", pageIndex];
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowDicArr,
        kSec_headerTitle : headerTitle,
        kSec_headerHeight : @(33.0),
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
    };
    
    MSYCommonTableSection *sectionModel = [[MSYCommonTableSection alloc] initWithDict:sectionDic];
    [self.sectionModelList addObject:sectionModel];
    
    self.listView.dataSource = self.sectionModelList;
    
    if (pageIndex == 0) {
        [self.listView stopHeaderRefreshingState];
    }
    else {
        [self.listView stopFooterRefreshingStateWithIsHadContent:YES];
    }
}

#pragma mark - MSYCommonTableViewDelegate

- (void)commonTableView:(MSYCommonTableView *)commonView headerRefreshActionWithPage:(NSUInteger)pageIndex {
    [self loadDataSourceWithPageIndex:pageIndex];
}

- (void)commonTableView:(MSYCommonTableView *)commonView footerRefreshActionWithPage:(NSUInteger)pageIndex {
    [self loadDataSourceWithPageIndex:pageIndex];
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
        _listView.isNeedHeaderRefresh = YES;
        _listView.isNeedFooterRefresh = YES;
        _listView.delegate = self;
    }
    return _listView;
}

- (NSMutableArray *)sectionModelList {
    if (!_sectionModelList) {
        _sectionModelList = [NSMutableArray array];
    }
    return _sectionModelList;
}

@end
