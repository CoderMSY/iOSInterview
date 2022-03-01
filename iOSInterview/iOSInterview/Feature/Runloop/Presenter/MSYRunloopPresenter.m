//
//  MSYRunloopPresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import "MSYRunloopPresenter.h"
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYRunLoopImageViewController.h"

@implementation MSYRunloopPresenter

#pragma mark - MSYPresenterCommonInput

- (void)fetchDataSource {
    NSArray *titleList = @[
        kRowRunloop_thead,
        kRowRunloop_thead_CFRunLoop,
        kRowRunloop_timer,
        kRowRunloop_monitorPerformanceLag,
        kRowRunloop_performanceOptimization,
    ];
    NSMutableArray *rowDicList = [NSMutableArray array];
    for (NSString *title in titleList) {
        NSDictionary *rowDic = @{
            kRow_title : title,
        };
        [rowDicList addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_headerTitle : kSecRunloop_apply,
        kSec_rowContent : rowDicList,
    };
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
    
    [(id<MSYPresenterCommonOutput>)self.viewController renderDataSource:dataSource];
}

- (void)pushRunLoopImageWithTitle:(NSString *)title {
    MSYRunLoopImageViewController *ctr = [[MSYRunLoopImageViewController alloc] init];
    ctr.title = title;
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

@end
