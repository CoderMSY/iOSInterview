//
//  MSYBasicViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "MSYBasicViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYBasicPresenter.h"
#import "UIImage+MSYWatermark.h"

@interface MSYBasicViewController () <MSYBasicPresenterOutput, MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYBasicPresenter *presenter;

@end

@implementation MSYBasicViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基础";
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self.presenter fetchDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
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

#pragma mark - thread

- (void)exampleThread:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowBasic_thread]) {
        [self.presenter pushThreadViewCtrWithTitle:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_GCD]) {
        [self.presenter pushGCDViewCtrWithTitle:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_operation]) {
        [self.presenter pushOperationViewCtrWithTitle:rowModel.title];
    }
}

#pragma mark - runtime

- (void)exampleRuntime:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowBasic_runtime]) {
        [self.presenter pushRuntimeViewCtr];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_runloop]) {
        [self.presenter pushRunloopViewCtr];
    }
}

#pragma mark - image

- (void)exampleImage:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowBasic_imageSynthesis]) {
        [self imageSynthesis];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_watermark]) {
        [self imageWatermark];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_imageCorner]) {
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

#pragma mark - collectionView

- (void)exampleCollectionView {
    [self.presenter pushCollectionExample];
}

#pragma mark - MSYBasicPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([sectionModel.headerTitle isEqualToString:kSecBasic_thread]) {
        [self exampleThread:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_runtime]) {
        [self exampleRuntime:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_image]) {
        [self exampleImage:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_collectionView]) {
        [self exampleCollectionView];
    }
    else {
        
    }
    
//    else if ([rowModel.title isEqualToString:kAlgorithm_findMedianInUnorderedArray]) {
//
//    }
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}

- (MSYBasicPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYBasicPresenter alloc] init];
        _presenter.output = self;
        _presenter.viewController = self;
    }
    return _presenter;
}

@end
