//
//  MSYKVCListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYKVCListViewController.h"
#import "MSYKVCListDefine.h"
#import "MSYKVCModel.h"
#import "MSYCommonTitleDetailCell.h"
#import "MSYCommonTitleDetailFrameModel.h"

@interface MSYKVCListViewController () <MSYTableViewProtocol>

@end

@implementation MSYKVCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataSource];
}

- (void)loadDataSource {
    NSArray *dicList = @[
        @{
            kRow_title : kRowKVC_setValue,
            kRow_detailTitle : @"1.按照setKey:、_setKey:顺序查找方法 \n2.如果没找到方法，并且accessInstanceVariablesDirectly返回YES，就开始查询成员变量；返回NO，调用NO \n3.按照_key、_isKey、key、isKey的顺序查找成员变量，未找到调用4 \n4.调用setValue:forUndefinedKey:，如未实现此方法则crash",
        },
        @{
            kRow_title : kRowKVC_valueForKey,
            kRow_detailTitle : @"1.按照getKey、key、isKey、_key的顺序查找 \n2.如果accessInstanceVariablesDirectly返回YES，就直接查询成员变量，否则调用4 \n3.按照_key、_isKey、key、isKey的顺序查找成员变量，未找到则调用4 \n4.调用valueForUndefinedKey:，如未实现此方法则crash",
        },
    ];
    NSMutableArray *rowList = [NSMutableArray array];
    for (NSDictionary *dic in dicList) {
        MSYCommonTitleDetailFrameModel *model = [[MSYCommonTitleDetailFrameModel alloc] init];
        model.title = dic[kRow_title];
        model.detail = dic[kRow_detailTitle];
        
        NSDictionary *rowDic = @{
            kRow_extraInfo : model,
            kRow_cellClass : NSStringFromClass([MSYCommonTitleDetailCell class]),
            kRow_rowHeight : @(model.cellHeight),
        };
        [rowList addObject:rowDic];
    }
    NSArray *secDicList = @[
        @{
            kSec_headerTitle : @"KVC",
            kSec_rowContent :rowList,
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
    ];
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:secDicList];
    
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kRowKVC_setValue]) {
        MSYKVCModel *model = [[MSYKVCModel alloc] init];
        
        [model setValue:@"100" forKey:@"age"];
    }
    else if ([rowModel.title isEqualToString:kRowKVC_valueForKey]) {
        MSYKVCModel *model = [[MSYKVCModel alloc] init];
        
        id value = [model valueForKey:@"age"];
        NSLog(@"value:%@", value);
    }
}

@end
