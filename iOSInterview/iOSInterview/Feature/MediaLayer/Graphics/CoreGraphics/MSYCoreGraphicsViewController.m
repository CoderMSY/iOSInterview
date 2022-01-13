//
//  MSYCoreGraphicsViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/22.
//

#import "MSYCoreGraphicsViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYCoreGraphicsTestView.h"
#import "MSYCoreGraphicsCell.h"
#import "MSYCoreGraphicsRectangularCell.h"
#import "MSYCoreGraphicsDefine.h"

@interface MSYCoreGraphicsViewController ()

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYCoreGraphicsTestView *coreGraphicsView;

@end

@implementation MSYCoreGraphicsViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.coreGraphicsView];
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
    //知识框架参考 https://www.jianshu.com/p/f342daf789af
    //官方 https://developer.apple.com/documentation/technologies?language=objc
//https://blog.csdn.net/leleyuan1130/article/details/50635060
    NSArray *dataList = @[
        @{
            kSec_headerTitle : @"Graphics Technologies 图形技术",
            kSec_rowContent : @[
                @{
                    kRow_title : @"CG画线（最原始的绘图方式）",
                    kRow_detailTitle : @"CGMutablePathRef",
                    kRow_extraInfo : @(MSYCGDrawType_line_mutPathRef),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"CG画线 设置属性Ctx",
                    kRow_detailTitle : @"CGContextMoveToPoint CGContextSet...",
                    kRow_extraInfo : @(MSYCGDrawType_line),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
//                @{
//                    kRow_title : @"贝塞尔曲线画线",
//                    kRow_detailTitle : @"UIBezierPath",
//                    kRow_extraInfo : @(2),
//                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
//                    kRow_rowHeight : @(200),
//                },
                @{
                    kRow_title : @"CG画矩形",
                    kRow_detailTitle : @"CGContextAddRect",
                    kRow_extraInfo : @(MSYCGDrawType_rect),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"CG画圆",
                    kRow_detailTitle : @"CGContextAddEllipseInRect",
                    kRow_extraInfo : @(MSYCGDrawType_circle),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"CG画椭圆",
                    kRow_detailTitle : @"CGContextAddEllipseInRect",
                    kRow_extraInfo : @(MSYCGDrawType_ellipse),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"CG绘制曲线",
                    kRow_detailTitle : @"bezierPathWithArcCenter",
                    kRow_extraInfo : @(MSYCGDrawType_curve),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"绘制文本",
                    kRow_detailTitle : @"bezierPathWithRoundedRect",
                    kRow_extraInfo : @(MSYCGDrawType_text),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"绘制图片",
                    kRow_detailTitle : @"bezierPathWithRoundedRect",
                    kRow_extraInfo : @(MSYCGDrawType_image),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
                @{
                    kRow_title : @"绘制水印",
                    kRow_detailTitle : @"bezierPathWithRoundedRect",
                    kRow_extraInfo : @(MSYCGDrawType_watermark),
                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsCell class]),
                    kRow_rowHeight : @(200),
                },
//                @{
//                    kRow_cellClass : NSStringFromClass([MSYCoreGraphicsRectangularCell class]),
//                    kRow_rowHeight : @(300),
//                },
            ],
        },
        @{
            kSec_headerTitle : @"Audio Technologies 音频技术",
            kSec_rowContent : @[
            ],
        },
        @{
            kSec_headerTitle : @"Video Technologies 视频技术",
            kSec_rowContent : @[
            ],
        },
        @{
            kSec_headerTitle : @"Graphics Technologies 图形技术",
            kSec_rowContent : @[
            ],
        },
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (NSDictionary *dic in rowContent) {
//            NSDictionary *rowDic = @{
//                kRow_cellClass : dic[kRow_cellClass] ? : @"",
//                kRow_rowHeight : dic[kRow_rowHeight],
//            };
            
            [rowDicArr addObject:dic];
        }
        
        NSDictionary *sectionDic = @{
            kSec_rowContent : rowDicArr,
            kSec_headerTitle : dataDic[kSec_headerTitle] ? : @"",
            kSec_headerHeight : @(33.0),
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        };
        
        [sectionArr addObject:sectionDic];
    }
    
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:sectionArr];
}

#pragma mark - getter && setter

- (MSYCoreGraphicsTestView *)coreGraphicsView {
    if (!_coreGraphicsView) {
        _coreGraphicsView = [[MSYCoreGraphicsTestView alloc] initWithFrame:self.view.bounds];
    }
    return _coreGraphicsView;
}

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
    }
    return _listView;
}

@end
