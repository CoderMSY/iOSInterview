//
//  MSYAlgorithmPresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "MSYAlgorithmPresenter.h"
#import <MSYTableView/MSYCommonTableData.h>
@implementation MSYAlgorithmPresenter

#pragma mark - MSYAlgorithmPresenterInput

- (void)fetchDataSource {
    NSArray *titleList = @[
        kAlgorithm_charReverse,
        kAlgorithm_orderedArrayMerge,
        kAlgorithm_findCommonParentView,
        kAlgorithm_findMedianInUnorderedArray,
    ];
    NSMutableArray *rowDicList = [NSMutableArray array];
    for (NSString *title in titleList) {
        NSDictionary *rowDic = @{
            kRow_title : title,
        };
        [rowDicList addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowDicList,
    };
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
    
    [self.output renderDataSource:dataSource];
}

@end
