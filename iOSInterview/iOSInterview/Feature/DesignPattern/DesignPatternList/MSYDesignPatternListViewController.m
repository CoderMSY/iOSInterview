//
//  MSYDesignPatternListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

#import "MSYDesignPatternListViewController.h"
#import "MSYCommonTitleDetailFrameModel.h"
#import "MSYCommonTitleDetailCell.h"

#import "MSYDesignPatternListDefine.h"
#import "MSYSimpleFactoryViewController.h"
#import "MSYMethodFactoryViewController.h"
#import "MSYAbstractFactoryViewController.h"
#import "MSYAdapterViewController.h"

@interface MSYDesignPatternListViewController () <MSYTableViewProtocol>

@end

@implementation MSYDesignPatternListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listView];
    
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)loadDataSource {
    //知识框架参考 https://www.jianshu.com/p/f342daf789af
    //官方 https://developer.apple.com/documentation/technologies?language=objc
    NSArray *dataList = @[
        @{
            kSec_headerTitle : kDPSectionTitle_creational,
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
        @{
            kSec_headerTitle : kDPSectionTitle_structural,
            kSec_rowContent : @[
                @{
                    kRow_title : kDPRowTitle_adapter_class,
                    kRow_detailTitle : @"当需要把一个已经实现了接口A的类A转换成能实现接口B的类时，可使用类适配器模式。",
                },
                @{
                    kRow_title : kDPRowTitle_adapter_instance,
                    kRow_detailTitle : @"当希望将接口A的实现类A的对象转换成满足接口B的对象时，可使用对象适配器的方式。",
                },
                @{
                    kRow_title : kDPRowTitle_adapter_interface,
                    kRow_detailTitle : @"有一个很大的接口，包含很多方法，当不希望实现接口中的所有方法时，可创建一个抽象类继承接口，但方法实现都是空的，实现类可继承这个抽象类实现了适配器的功能。",
                },
            ],
        }
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (NSDictionary *itemDic in rowContent) {
            MSYCommonTitleDetailFrameModel *model = [[MSYCommonTitleDetailFrameModel alloc] init];
            model.title = itemDic[kRow_title];
            model.detail = itemDic[kRow_detailTitle];
            
            NSDictionary *rowDic = @{
                kRow_title : model.title ? : @"",
                kRow_extraInfo : model,
                kRow_cellClass : NSStringFromClass([MSYCommonTitleDetailCell class]),
                kRow_rowHeight : @(model.cellHeight),
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

#pragma mark - 创建型

- (void)exampleCreational:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kDPRowTitle_simpleFactory]) {
        [self pushNextPageWithCtr:MSYSimpleFactoryViewController.new title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_factoryMethod]) {
        [self pushNextPageWithCtr:MSYMethodFactoryViewController.new title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_abstractFactory]) {
        [self pushNextPageWithCtr:MSYAbstractFactoryViewController.new title:rowModel.title];
    }
}

#pragma mark - 结构性

- (void)exampleStructural:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kDPRowTitle_adapter_class]) {
        MSYAdapterViewController *ctr = [[MSYAdapterViewController alloc] init];
        ctr.adapterType = MSYAdapterType_class;
        [self pushNextPageWithCtr:ctr title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_adapter_instance]) {
        MSYAdapterViewController *ctr = [[MSYAdapterViewController alloc] init];
        ctr.adapterType = MSYAdapterType_instance;
        [self pushNextPageWithCtr:ctr title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kDPRowTitle_adapter_interface]) {
        MSYAdapterViewController *ctr = [[MSYAdapterViewController alloc] init];
        ctr.adapterType = MSYAdapterType_interface;
        [self pushNextPageWithCtr:ctr title:rowModel.title];
    }
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([sectionModel.headerTitle isEqualToString:kDPSectionTitle_creational]) {
        [self exampleCreational:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kDPSectionTitle_structural]) {
        [self exampleStructural:rowModel];
    }
}

#pragma mark - getter && setter


@end
