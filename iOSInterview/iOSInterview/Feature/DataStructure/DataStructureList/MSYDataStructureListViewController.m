//
//  MSYDataStructureListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/24.
//

#import "MSYDataStructureListViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYDataStructureListDefine.h"
#import "MSYHashOCImplViewController.h"

@interface MSYDataStructureListViewController () <MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation MSYDataStructureListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    //知识框架参考 https://www.jianshu.com/p/f342daf789af
    //官方 https://developer.apple.com/documentation/technologies?language=objc
    NSArray *dataList = @[
        @{
            kSec_headerTitle : @"数据结构",
            kSec_rowContent : @[
                kDSTitle_hashOC,
            ],
        },
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (NSString *title in rowContent) {
            NSDictionary *rowDic = @{
                kRow_title : title ? : @"",
            };
            
            [rowDicArr addObject:rowDic];
        }
        
        NSDictionary *sectionDic = @{
            kSec_rowContent : rowDicArr,
            kSec_headerTitle : dataDic[kSec_headerTitle] ? : @"",
            kSec_headerHeight : @(33.0),
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        };
        
        [sectionArr addObject:sectionDic];
    }
    
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:sectionArr];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kDSTitle_hashOC]) {
        MSYHashOCImplViewController *ctr = [[MSYHashOCImplViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
//    else if ([rowModel.title isEqualToString:kALTitle_openHole3DBanner]) {
//        MSYOpenHole3DBannerViewController *ctr = [[MSYOpenHole3DBannerViewController alloc] init];
//        ctr.title = rowModel.title;
//        [self.navigationController pushViewController:ctr animated:YES];
//    }
}

#pragma mark - getter && setter


- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
    }
    return _listView;
}


@end
