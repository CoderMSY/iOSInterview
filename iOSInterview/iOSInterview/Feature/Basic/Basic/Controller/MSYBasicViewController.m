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
#import "MSYKVOViewController.h"

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

#pragma mark - OC Grammar

- (void)exampleOCGrammar:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowBasic_block]) {
        [self.presenter pushBlockViewCtrWithTitle:rowModel.title];
    }
    else if ([rowModel.title isEqualToString:kRowBasic_KVO]) {
        [self.presenter pushNextPageWithCtr:MSYKVOViewController.new
                                      title:rowModel.title];
    }
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

#pragma mark - collectionView

- (void)exampleCollectionView {
    [self.presenter pushCollectionExample];
}

#pragma mark - other

- (void)exampleOther:(MSYCommonTableRow *)rowModel {
//    if ([rowModel.title isEqualToString:kRowBasic_flutter]) {
//        [self.presenter pushFlutterModule];
//    }
}

#pragma mark - MSYBasicPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([sectionModel.headerTitle isEqualToString:kSecBasic_OCGrammar]) {
        [self exampleOCGrammar:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_thread]) {
        [self exampleThread:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_runtime]) {
        [self exampleRuntime:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_autoreleasepool]) {
        [self.presenter pushAutoreleasePoolViewCtr];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_collectionView]) {
        [self exampleCollectionView];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecBasic_other]) {
        [self exampleOther:rowModel];
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
