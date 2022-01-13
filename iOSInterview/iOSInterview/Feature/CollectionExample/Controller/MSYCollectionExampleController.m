//
//  MSYCollectionExampleController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/10/15.
//

#import "MSYCollectionExampleController.h"
#import <Masonry/Masonry.h>

#import "MSYCollectionExampleView.h"

@interface MSYCollectionExampleController ()

@property (nonatomic, strong) MSYCollectionExampleView *exampleView;

@end

@implementation MSYCollectionExampleController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.exampleView];
    [self initConstraints];
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.exampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    NSArray *list = @[
        @"湖人",
        @"勇士",
        @"篮网",
        @"爵士",
        @"马刺",
        @"太阳",
        @"last",
//        @"小牛",
//        @"凯尔特人",
//        @"雷霆",
//        @"火箭",
//        @"骑士",
//        @"热火",
//        @"76人",
//        @"掘金",
    ];
    self.exampleView.dataSource = [NSMutableArray arrayWithArray:list];
}

#pragma mark - getter && setter

- (MSYCollectionExampleView *)exampleView {
    if (!_exampleView) {
        _exampleView = [[MSYCollectionExampleView alloc] init];
    }
    return _exampleView;
}

@end
