//
//  MSYRuntimePresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "MSYRuntimePresenter.h"
#import <MSYTableView/MSYCommonTableData.h>

@implementation MSYRuntimePresenter

#pragma mark - MSYRuntimePresenterInput

- (void)fetchDataSource {
    NSArray *secDicList = @[
        @{
            kSec_headerTitle : kSecRuntime_class,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowRuntime_class_allocateClassPair,
                    },
                    @{
                        kRow_title : kRowRuntime_class_registerClassPair,
                    },
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecRuntime_instance,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowRuntime_instanceVariable,
                    },
//                    @{
//                        kRow_title : kRowBasic_watermark,
//                    },
//                    @{
//                        kRow_title : kRowBasic_imageCorner,
//                    }
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
        @{
            kSec_headerTitle : kSecRuntime_apply,
            kSec_rowContent : @[
                    @{
                        kRow_title : kRowRuntime_apply_ivar,
                    },
                    @{
                        kRow_title : kRowRuntime_apply_jsonToModel,
                    },
                    @{
                        kRow_title : kRowRuntime_apply_methodExchange,
                    },
            ],
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        },
    ];
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:secDicList];
    
    [(id<MSYRuntimePresenterOutput>)self.viewController renderDataSource:dataSource];
}

@end
