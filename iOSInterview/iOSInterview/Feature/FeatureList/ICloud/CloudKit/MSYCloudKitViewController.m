//
//  MSYCloudKitViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import "MSYCloudKitViewController.h"
#import "MSYCloudKitAddViewController.h"
#import "MSYCloudKitTool.h"

@interface MSYCloudKitViewController () <MSYTableViewProtocol>

@end

@implementation MSYCloudKitViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createRightItem];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)createRightItem {
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClicked:)];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)addItemClicked:(UIBarButtonItem *)sender {
    MSYCloudKitAddViewController *ctr = [[MSYCloudKitAddViewController alloc] init];
    ctr.cloudKitType = MSYCloudKitType_add;
    [self pushNextPageWithCtr:ctr title:@"新增"];
}

- (void)loadDataSource {
    [MSYCloudKitTool queryCloudKitDataComplete:^(NSArray<CKRecord *> * _Nullable results) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSMutableArray *rowDicList = [NSMutableArray array];
            for (CKRecord *record in results) {
                NSDictionary *rowDic = @{
                    kRow_title : [record objectForKey:@"title"] ? : @"",
                    kRow_detailTitle : [record objectForKey:@"content"] ? : @"",
                    kRow_extraInfo : record,
                };
                [rowDicList addObject:rowDic];
            }
            
            NSDictionary *sectionDic = @{
                kSec_headerTitle : @"文件列表",
                kSec_footerHeight : @(kSectionHeaderHeight_zero),
                kSec_rowContent : rowDicList,
            };
            self.listView.dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
        });
    }];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.extraInfo isKindOfClass:[CKRecord class]]) {
        CKRecord *record = (CKRecord *)rowModel.extraInfo;
        
        MSYCloudKitAddViewController *ctr = [[MSYCloudKitAddViewController alloc] init];
        ctr.cloudKitType = MSYCloudKitType_edit;
        ctr.recordID = record.recordID;
        [self pushNextPageWithCtr:ctr title:rowModel.title];
    }
}

#pragma mark - getter && setter

@end
