//
//  MSYFeatureListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import "MSYFeatureListViewController.h"
//#import <Masonry/Masonry.h>
//#import <MSYTableView/MSYCommonTableView.h>
//#import <MSYTableView/MSYCommonTableData.h>
//#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYFeatureListDefine.h"
#import "MSYDatabaseListViewController.h"
#import "MSYBgKeepAliveListViewController.h"
#import "UIImage+MSYWatermark.h"
#import "MSYICoudKeyValueViewController.h"
#import "MSYICoudDocumentViewController.h"
#import "MSYCloudKitViewController.h"

@interface MSYFeatureListViewController () <MSYTableViewProtocol>

//@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation MSYFeatureListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.listView];
//    [self initConstraints];
    
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

//- (void)initConstraints {
//    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
//}

- (void)loadDataSource {
    //知识框架参考 https://www.jianshu.com/p/f342daf789af
    //官方 https://developer.apple.com/documentation/technologies?language=objc
    NSArray *dataList = @[
        @{
            kSec_headerTitle : kSecFeature_SQL,
            kSec_rowContent : @[
                kRowFeature_databaseFileEncrpt,
            ],
        },
        @{
            kSec_headerTitle : kSecFeature_iCloud,
            kSec_rowContent : @[
                kRowFeature_iCloud_keyValue,
                kRowFeature_iCloud_document,
                kRowFeature_iCloud_cloudKit,
            ],
        },
        @{
            kSec_headerTitle : kSecFeature_background,
            kSec_rowContent : @[
                kRowFeature_backgroundKeepAlive,
            ],
        },
        @{
            kSec_headerTitle : kSecFeature_image,
            kSec_rowContent : @[
                kRowFeature_imageSynthesis,
                kRowFeature_watermark,
                kRowFeature_imageCorner,
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
    
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:sectionArr];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([sectionModel.headerTitle isEqualToString:kSecFeature_SQL]) {
        if ([rowModel.title isEqualToString:kRowFeature_databaseFileEncrpt]) {
            [self pushNextPageWithCtr:MSYDatabaseListViewController.new title:rowModel.title];
        }
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecFeature_iCloud]) {
        [self exampleIClound:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecFeature_background]) {
        [self exampleBackground:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecFeature_image]) {
        [self exampleImage:rowModel];
    }
}

- (void)exampleBackground:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowFeature_backgroundKeepAlive]) {
        MSYBgKeepAliveListViewController *ctr = [[MSYBgKeepAliveListViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

#pragma mark - iCloud
- (void)exampleIClound:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowFeature_iCloud_keyValue]) {
        [self pushNextPageWithCtr:MSYICoudKeyValueViewController.new title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kRowFeature_iCloud_document]) {
        [self pushNextPageWithCtr:MSYICoudDocumentViewController.new title:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kRowFeature_iCloud_cloudKit]) {
        [self pushNextPageWithCtr:MSYCloudKitViewController.new title:rowModel.title];
    }
}

#pragma mark - image

- (void)exampleImage:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowFeature_imageSynthesis]) {
        [self imageSynthesis];
    }
    else if ([rowModel.title isEqualToString:kRowFeature_watermark]) {
        [self imageWatermark];
    }
    else if ([rowModel.title isEqualToString:kRowFeature_imageCorner]) {
        [self imageCorner];
    }
}

- (void)imageSynthesis {
    NSArray *dicList = @[
        @{@"color" : [UIColor redColor], @"size" : @(CGSizeMake(200, 10))},
        @{@"color" : [UIColor yellowColor], @"size" : @(CGSizeMake(150, 20))},
        @{@"color" : [UIColor greenColor], @"size" : @(CGSizeMake(300, 30))},
        @{@"color" : [UIColor cyanColor], @"size" : @(CGSizeMake(10, 40))},
        @{@"color" : [UIColor blueColor], @"size" : @(CGSizeMake(60, 50))},
        @{@"color" : [UIColor purpleColor], @"size" : @(CGSizeMake(100, 60))},
    ];
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSDictionary *dic in dicList) {
        UIColor *color = dic[@"color"];
        NSNumber *sizeNum = dic[@"size"];
        
        UIImage *image = [UIImage msy_imageWithColor:color size:[sizeNum CGSizeValue]];
        [imageList addObject:image];
    }
    
    UIImage *resultImage = [UIImage msy_imageSynthesisWithImageList:imageList];
    UIImageView *bgIV = [[UIImageView alloc] init];
    bgIV.image = resultImage;
    bgIV.frame = CGRectMake(30, 90, resultImage.size.width, resultImage.size.height);
    bgIV.layer.borderWidth = 1.0;
    bgIV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self showContentView:bgIV];
}

- (void)imageWatermark {
    UIImage *bgImage = [UIImage msy_imageWithColor:[UIColor yellowColor] size:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImage *watermarkImage = [UIImage msy_getWaterMarkImage:bgImage title:@"watermark" markFont:[UIFont systemFontOfSize:17] markColor:[UIColor lightGrayColor]];
    
    UIImageView *bgIV = [[UIImageView alloc] init];
    bgIV.image = watermarkImage;
    bgIV.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    
    [self showContentView:bgIV];
}

- (void)imageCorner {
    UIImage *avatarImage = [UIImage msy_imageWithColor:[UIColor blueColor] size:CGSizeMake(100, 100)];
    UIImageView *avatarIV = [[UIImageView alloc] init];
    avatarIV.image = avatarImage;
    avatarIV.frame = CGRectMake(100, 100, avatarImage.size.width, avatarImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(avatarIV.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:avatarIV.bounds cornerRadius:avatarIV.bounds.size.width] addClip];
    [avatarIV drawRect:avatarIV.bounds];
    avatarIV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self showContentView:avatarIV];
}

- (void)showContentView:(UIView *)contentView {
    if (!contentView) {
        return;
    }
    UIViewController *viewCtr = [[UIViewController alloc] init];
    viewCtr.view.backgroundColor = [UIColor whiteColor];
    
    [viewCtr.view addSubview:contentView];
    [self.navigationController pushViewController:viewCtr animated:YES];
}

#pragma mark - getter && setter


//- (MSYCommonTableView *)listView {
//    if (!_listView) {
//        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
//    }
//    return _listView;
//}

@end
