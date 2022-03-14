//
//  FBKVOListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "FBKVOListViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "FBKVOListCell.h"

@interface FBKVOListViewController ()

@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation FBKVOListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"FBKVO List";
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
    NSMutableArray *rowList = [NSMutableArray array];
    for (NSInteger i = 0; i < 30; i++) {
        NSNumber *num = @(i);
        NSDictionary *rowDic = @{
            kRow_title : num.stringValue,
            kRow_extraInfo : num,
            kRow_cellClass : NSStringFromClass([FBKVOListCell class])
        };
        [rowList addObject:rowDic];
    }
    NSDictionary *sectionDic = @{
        kSec_headerHeight : @(kSectionHeaderHeight_zero),
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
        kSec_rowContent : rowList,
    };
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
    
    self.listView.dataSource = dataSource;
}


#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    
    if ([rowModel.extraInfo isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)rowModel.extraInfo;
        num = @(num.integerValue + 1);
        rowModel.extraInfo = num;
        rowModel.title = num.stringValue;
    }
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}

@end
