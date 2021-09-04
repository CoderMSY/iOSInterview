//
//  MSYAlgorithmViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "MSYAlgorithmViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYAlgorithmPresenter.h"
#import "MSYAlgorithmTool.h"

@interface MSYAlgorithmViewController () <MSYAlgorithmPresenterOutput, MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYAlgorithmPresenter *presenter;

@end

@implementation MSYAlgorithmViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"算法";
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

- (void)charReverse {
    char cha[] = "Hello, World";
    NSLog(@"%s", cha);
    char_reverse(cha);
}




#pragma mark - MSYAlgorithmPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kAlgorithm_charReverse]) {
        [self charReverse];
    }
    else if ([rowModel.title isEqualToString:kAlgorithm_orderedArrayMerge]) {
        int array1[6] = {1,3,12,23,30,50};
        int array2[8] = {2,5,11,20,28,60,67,87};
        int result[14];
        mergeSortedList(array1, 6, array2, 8, result);
//        NSLog(@"%d", *result); *result:取result数组的首位数字
        for (int i = 0; i < 14; i++) {
            NSLog(@"%d", result[i]);
        }
    }
    else if ([rowModel.title isEqualToString:kAlgorithm_findCommonParentView]) {
        NSArray *resultList = [MSYAlgorithmTool findCommonSuperView:self.listView other:self.listView.tableView];
        NSLog(@"resultList:%@", resultList);
    }
    else if ([rowModel.title isEqualToString:kAlgorithm_findMedianInUnorderedArray]) {
        int list[9] = {5,3,10,8,6,7,30,13,9};
                    // 3 5 6 7 8 9 10 13 30
        int median = findMedianInUnorderedArray(list, 9);
        
        NSLog(@"中位数: %d", median);
    }
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}

- (MSYAlgorithmPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYAlgorithmPresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}

@end
