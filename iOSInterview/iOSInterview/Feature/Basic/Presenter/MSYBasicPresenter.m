//
//  MSYBasicPresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "MSYBasicPresenter.h"
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYThreadViewController.h"
#import "MSYGCDViewController.h"
#import "MSYOperationViewController.h"
#import "MSYRuntimeViewController.h"
#import "MSYRunloopViewController.h"
#import "MSYAutoreleasePoolViewController.h"
#import "MSYCollectionExampleController.h"

@implementation MSYBasicPresenter

#pragma mark - MSYBasicPresenterInput

- (void)fetchDataSource {
    NSArray *secDicList = @[
        @{
            kSec_headerTitle : kSecBasic_thread,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowBasic_thread,
                    },
                    @{
                        kRow_title : kRowBasic_GCD,
                    },
                    @{
                        kRow_title : kRowBasic_operation,
                    },
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecBasic_runtime,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowBasic_runtime,
                    },
                    @{
                        kRow_title : kRowBasic_runloop,
                    },
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecBasic_autoreleasepool,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowBasic_autoreleasepool,
                }
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecBasic_image,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowBasic_imageSynthesis,
                    },
                    @{
                        kRow_title : kRowBasic_watermark,
                    },
                    @{
                        kRow_title : kRowBasic_imageCorner,
                    }
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecBasic_collectionView,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowBasic_collectionView,
                    },
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
    ];
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:secDicList];
    
    [self.output renderDataSource:dataSource];
}

- (void)pushThreadViewCtrWithTitle:(NSString *)title {
    MSYThreadViewController *ctr = [[MSYThreadViewController alloc] init];
    ctr.title = title;
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushGCDViewCtrWithTitle:(NSString *)title {
    MSYGCDViewController *ctr = [[MSYGCDViewController alloc] init];
    ctr.title = title;
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushOperationViewCtrWithTitle:(NSString *)title {
    MSYOperationViewController *ctr = [[MSYOperationViewController alloc] init];
    ctr.title = title;
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushRuntimeViewCtr {
    MSYRuntimeViewController *ctr = [[MSYRuntimeViewController alloc] init];
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushRunloopViewCtr {
    MSYRunloopViewController *ctr = [[MSYRunloopViewController alloc] init];
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushAutoreleasePoolViewCtr {
    MSYAutoreleasePoolViewController *ctr = [[MSYAutoreleasePoolViewController alloc] init];
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

- (void)pushCollectionExample {
    MSYCollectionExampleController *ctr = [[MSYCollectionExampleController alloc] init];
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

#pragma mark - other

@end
