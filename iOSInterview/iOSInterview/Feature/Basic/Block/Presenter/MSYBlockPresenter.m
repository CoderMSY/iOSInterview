//
//  MSYBlockPresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/10.
//

#import "MSYBlockPresenter.h"
#import <MSYTableView/MSYCommonTableData.h>

@implementation MSYBlockPresenter

#pragma mark - MSYBlockPresenterInput

- (void)fetchDataSource {
    NSArray *dataList = @[
        @{
            kSec_headerTitle : @"block",
            kSec_rowContent : @[
                kBlockTitle_variableCapture,
                kBlockTitle_blockType,
                kBlockTitle_arcAutoCopy,
                kBlockTitle___block,
                kBlockTitle_resolveRetainCycle,
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
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:sectionArr];
    [self.output renderDataSource:dataSource];
}

@end
