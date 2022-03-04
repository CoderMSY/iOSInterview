//
//  MSYDesignPatternListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYDesignPatternListViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYDesignPatternListDefine.h"
#import "MSYSimpleFactoryViewController.h"
#import "MSYMethodFactoryViewController.h"
#import "MSYAbstractFactoryViewController.h"

@interface MSYDesignPatternListViewController () <MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation MSYDesignPatternListViewController

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
            kSec_headerTitle : kDPSectionTitle_factory,
            kSec_rowContent : @[
                @{
                    kRow_title : kDPRowTitle_simpleFactory,
                    kRow_detailTitle : @"可以根据不同的参数返回不同类的实例对象。",
                },
                @{
                    kRow_title : kDPRowTitle_factoryMethod,
                    kRow_detailTitle : @"针对不同的实例对象提供不同的工厂",
                },
                @{
                    kRow_title : kDPRowTitle_abstractFactory,
                    kRow_detailTitle : @"每个抽象工厂派生多个具体工厂类，每个具体工厂负责多个具体产品的实例创建。",
                },
            ],
        },
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (NSDictionary *itemDic in rowContent) {
            NSString *title = itemDic[kRow_title];
            NSString *detailTitle = itemDic[kRow_detailTitle];
            NSDictionary *rowDic = @{
                kRow_title : title ? : @"",
                kRow_detailTitle : detailTitle ? : @"",
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
    if ([rowModel.title isEqualToString:kDPRowTitle_simpleFactory]) {
        MSYSimpleFactoryViewController *ctr = [[MSYSimpleFactoryViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_factoryMethod]) {
        MSYMethodFactoryViewController *ctr = [[MSYMethodFactoryViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_abstractFactory]) {
        MSYAbstractFactoryViewController *ctr = [[MSYAbstractFactoryViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

#pragma mark - getter && setter


- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
    }
    return _listView;
}


@end
