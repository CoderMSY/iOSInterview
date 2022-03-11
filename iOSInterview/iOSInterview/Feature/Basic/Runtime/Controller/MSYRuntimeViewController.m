//
//  MSYRuntimeViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "MSYRuntimeViewController.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYRuntimePresenter.h"
#import "MSYPerson.h"
#import "NSObject+MSYJson.h"

@interface MSYRuntimeViewController () <MSYRuntimePresenterOutput, MSYTableViewProtocol>

@property (nonatomic, strong) MSYRuntimePresenter *presenter;
@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation MSYRuntimeViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Runtime";
    
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

- (void)classMethod:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowRuntime_class_allocateClassPair]) {
        // 创建类
        Class newClass = objc_allocateClassPair([NSObject class], "MSYPerson1", 0);
        //动态添加成员变量（已经注册的类是不能动态添加成员变量的）
        class_addIvar(newClass, "_age", 4, 1, @encode(int));
        class_addIvar(newClass, "_height", 4, 1, @encode(int));
        // 注册类
        objc_registerClassPair(newClass);
        
//        id person = [[newClass alloc] init];
//        [person setValue:@10 forKey:@"_age"];
//        [person setValue:@20 forKey:@"_height"];
//        NSLog(@"%@ %@", [person valueForKey:@"_age"], [person valueForKey:@"_height"]);
        
        // 在不需要这个类时释放
        objc_disposeClassPair(newClass);
    }
    else if ([rowModel.title isEqualToString:kRowRuntime_class_registerClassPair]) {
        
    }
}

- (void)instanceMethod:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowRuntime_instanceVariable]) {
        //
    }
    else if ([rowModel.title isEqualToString:kRowRuntime_class_registerClassPair]) {
        
    }
}

- (void)applyMethod:(MSYCommonTableRow *)rowModel {
    if ([rowModel.title isEqualToString:kRowRuntime_apply_ivar]) {
        unsigned int count;
        Ivar *ivars = class_copyIvarList([UITextField class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        }
        free(ivars);
    }
    else if ([rowModel.title isEqualToString:kRowRuntime_apply_jsonToModel]) {
        NSDictionary *json = @{
            @"id" : @20,
            @"age" : @20,
            @"weight" : @60,
            @"name" : @"Jack"
        };
        MSYPerson *person = [MSYPerson msy_objectWithJson:json];
        NSLog(@"%@ %@ %@ %@", person.name, person.ID, person.age, person.weight);
    }
    else if ([rowModel.title isEqualToString:kRowRuntime_apply_methodExchange]) {
        MSYPerson *person = [[MSYPerson alloc] init];
        Method runMethod = class_getInstanceMethod([MSYPerson class], @selector(run));
        Method testMethod = class_getInstanceMethod([MSYPerson class], @selector(test));
        method_exchangeImplementations(runMethod, testMethod);
        
        [person run];
    }
}

#pragma mark - MSYRuntimePresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([sectionModel.headerTitle isEqualToString:kSecRuntime_class]) {
        [self classMethod:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecRuntime_instance]) {
        [self instanceMethod:rowModel];
    }
    else if ([sectionModel.headerTitle isEqualToString:kSecRuntime_apply]) {
        [self applyMethod:rowModel];
    }
}

#pragma mark - getter && setter

- (MSYRuntimePresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYRuntimePresenter alloc] init];
        _presenter.viewController = self;
    }
    return _presenter;
}

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}

@end
