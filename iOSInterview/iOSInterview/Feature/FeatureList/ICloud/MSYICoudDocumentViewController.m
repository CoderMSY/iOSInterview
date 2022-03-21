//
//  MSYICoudDocumentViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/19.
//

#import "MSYICoudDocumentViewController.h"
#import <DateTools/DateTools.h>
#import "MSYICoudDocumentAddViewController.h"
#import "MSYICloudTool.h"

@interface MSYICoudDocumentViewController () <MSYTableViewProtocol>

//主要用来查询数据
@property (nonatomic, strong) NSMetadataQuery *metadataQuery;

@end

@implementation MSYICoudDocumentViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createRightItem];
    [self addNotification];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MSYICloudTool getNewDocument:self.metadataQuery];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

#pragma mark - notice
 
- (void)addNotification {
    //获取最新数据完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedGetNewDocument:) name:NSMetadataQueryDidFinishGatheringNotification object:self.metadataQuery];
    
    //数据更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentDidChange:) name:NSMetadataQueryDidUpdateNotification object:self.metadataQuery];
}

- (void)finishedGetNewDocument:(NSNotification *)noti {
    NSLog(@"%s %@", __func__, noti.name);
    
    if (![noti.object isKindOfClass:[NSMetadataQuery class]]) {
        return;
    }
    NSMetadataQuery *metadataQuery = (NSMetadataQuery *)noti.object;
    
    NSArray *fileList = metadataQuery.results;
    
    NSMutableArray *rowDicList = [NSMutableArray array];
    for (NSMetadataItem *item in fileList) {
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        NSString *changeDateStr = [date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDictionary *rowDic = @{
            kRow_title : [item valueForAttribute:NSMetadataItemFSNameKey] ? : @"",
            kRow_detailTitle : changeDateStr ? : @"",
            kRow_extraInfo : item,
        };
        [rowDicList addObject:rowDic];
    }
    NSDictionary *sectionDic = @{
        kSec_headerTitle : @"文件列表",
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
        kSec_rowContent : rowDicList,
    };
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
}

- (void)documentDidChange:(NSNotification *)noti {
    NSLog(@"%s %@", __func__, noti.name);
    
    if (![noti.object isKindOfClass:[NSMetadataQuery class]]) {
        return;
    }
//    NSMetadataQuery *metadataQuery = (NSMetadataQuery *)noti.object;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.extraInfo isKindOfClass:[NSMetadataItem class]]) {
        MSYICoudDocumentAddViewController *ctr = [[MSYICoudDocumentAddViewController alloc] init];
        ctr.docType = MSYICloudDocType_edit;
        ctr.metadataItem = rowModel.extraInfo;
        [self pushNextPageWithCtr:ctr title:rowModel.title];
    }
}

#pragma mark - private methods

- (void)createRightItem {
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClicked:)];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)addItemClicked:(UIBarButtonItem *)sender {
    MSYICoudDocumentAddViewController *ctr = [[MSYICoudDocumentAddViewController alloc] init];
    ctr.docType = MSYICloudDocType_add;
    [self pushNextPageWithCtr:ctr title:@"新增"];
}

#pragma mark - getter && setter

- (NSMetadataQuery *)metadataQuery {
    if (!_metadataQuery) {
        _metadataQuery = [[NSMetadataQuery alloc] init];
    }
    return _metadataQuery;
}

@end
