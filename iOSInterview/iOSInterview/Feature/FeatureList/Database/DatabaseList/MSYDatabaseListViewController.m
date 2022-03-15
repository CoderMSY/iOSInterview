//
//  MSYDatabaseListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/14.
//

#import "MSYDatabaseListViewController.h"
//#import <UIAlertController+Blocks/UIAlertController+Blocks.h>
#import "UIAlertController+Blocks.h"
//#import "MSYCommonTitleDetailCell.h"
//#import "MSYCommonTitleDetailFrameModel.h"

#import "MSYDatabaseListDefine.h"
#import "MSYDaoFactory.h"

@interface MSYDatabaseListViewController () <MSYTableViewProtocol>

@end

@implementation MSYDatabaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataSource];
    
}

- (void)loadDataSource {
    NSArray *sectionDicList = @[
        @{
            kSec_headerTitle : @"Db1",
            kSec_rowContent : @[
                kRowDatabase_createUnEncrptedDb1,
                kRowDatabase_readUnEncrptedDb1,
                kRowDatabase_encrptDb1,
                kRowDatabase_readEncrptDb1,
            ]
        },
        @{
            kSec_headerTitle : @"Db2",
            kSec_rowContent : @[
                kRowDatabase_createEncrptedDb2,
                kRowDatabase_readEncrptedDb2,
                kRowDatabase_decryptDb2,
                kRowDatabase_readDecryptDb2
            ]
        }
    ];
    NSMutableArray *sectionList = [NSMutableArray array];
    for (NSDictionary *sectionDic in sectionDicList) {
        NSMutableArray *rowList = [NSMutableArray array];
        NSArray *rowContentList = sectionDic[kSec_rowContent];
        for (NSString *title in rowContentList) {
            NSDictionary *rowDic = @{
                kRow_title : title,
            };
            [rowList addObject:rowDic];
        }
        NSDictionary *secDic =  @{
            kSec_headerTitle : sectionDic[kSec_headerTitle] ? : @"",
            kSec_rowContent :rowList,
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        };
        [sectionList addObject:secDic];
    }
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:sectionList];
    
    self.listView.dataSource = dataSource;
}

- (void)showAlertWithMessage:(NSString *)message {
    [UIAlertController showAlertInViewController:self withTitle:@"提示" message:message cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
    }];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kRowDatabase_createUnEncrptedDb1]) {
        BOOL isSuccess = [[_DaoFactory getDb1Dao] createUnencryptDb1AndInsertData];
        NSString *message = isSuccess ? @"数据插入成功" : @"数据插入失败";
        [self showAlertWithMessage:message];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_readUnEncrptedDb1]) {
        [[_DaoFactory getDb1Dao] readUnencryptDb1:^(NSInteger count) {
            rowModel.detailTitle = [NSString stringWithFormat:@"%ld", count];
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_encrptDb1]) {
        BOOL isSuccess = [[_DaoFactory getDb1Dao] encryptDb1];
        NSString *message = isSuccess ? @"db1加密成功" : @"db1加密失败";
        
        [self showAlertWithMessage:message];
        
        if (isSuccess) {
            rowModel.title = kRowDatabase_decryptDb1;
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_readEncrptDb1]) {
        [[_DaoFactory getDb1Dao] readEncrptDb1:^(NSInteger count) {
            rowModel.detailTitle = [NSString stringWithFormat:@"%ld", count];
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_decryptDb1]) {
        BOOL isSuccess = [[_DaoFactory getDb1Dao] decryptDb1];
        NSString *message = isSuccess ? @"db1解密成功" : @"db1解密失败";
        
        [self showAlertWithMessage:message];
        
        if (isSuccess) {
            rowModel.title = kRowDatabase_encrptDb1;
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_createEncrptedDb2]) {
        BOOL isSuccess = [[_DaoFactory getDb2Dao] createEncryptDb2];
        NSString *message = isSuccess ? @"加密数据库db2创建成功" : @"加密数据库db2创建失败";
        
        [self showAlertWithMessage:message];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_readEncrptedDb2]) {
        [[_DaoFactory getDb2Dao] readEncryptDb2:^(NSInteger count) {
            rowModel.detailTitle = [NSString stringWithFormat:@"%ld", count];
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_decryptDb2]) {
        BOOL isSuccess = [[_DaoFactory getDb2Dao] decryptDb2];
        
        NSString *message = isSuccess ? @"db2解密成功" : @"db2解密失败";
        
        [self showAlertWithMessage:message];
        if (isSuccess) {
            rowModel.title = kRowDatabase_encrptDb2;
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_readDecryptDb2]) {
        [[_DaoFactory getDb2Dao] readDecryptDb2:^(NSInteger count) {
            rowModel.detailTitle = [NSString stringWithFormat:@"%ld", count];
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }];
    }
    else if ([rowModel.title isEqualToString:kRowDatabase_encrptDb2]) {
        BOOL isSuccess = [[_DaoFactory getDb2Dao] encrptDb2];
        NSString *message = isSuccess ? @"db2加密成功" : @"db2加密失败";
        [self showAlertWithMessage:message];
        
        if (isSuccess) {
            rowModel.title = kRowDatabase_decryptDb2;
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[indexPath]];
        }
    }
}


@end
