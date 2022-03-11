//
//  MSYBlockViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/10.
//

#import "MSYBlockViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYBlockPresenter.h"
typedef void (^MSYBlock)(void);
int kBlockWeight = 130;

@interface MSYBlockViewController () <MSYBlockPresenterOutput, MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYBlockPresenter *presenter;
@property (nonatomic, strong) MSYBlock block1;
@property (nonatomic, strong) MSYBlock block2;
@property (nonatomic, strong) MSYBlock block3;

@end

@implementation MSYBlockViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark - MSYBlockPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kBlockTitle_variableCapture]) {
        [self exampleVariableCapture];
    }
    else if ([rowModel.title isEqualToString:kBlockTitle_blockType]) {
        [self exampleBlockType];
    }
    else if ([rowModel.title isEqualToString:kBlockTitle_arcAutoCopy]) {
        [self exampleArcAutoCopy];
    }
    else if ([rowModel.title isEqualToString:kBlockTitle___block]) {
        [self example__block];
    }
    else if ([rowModel.title isEqualToString:kBlockTitle_resolveRetainCycle]) {
        [self exampleResolveRetainCycle];
    }
}

#pragma mark - variableCapture

int kBlock_c = 10;

/* block变量捕获机制：
 auto局部变量：值传递（捕获到内部，但无法修改外部变量）
 static局部变量：指针传递（捕获到内部，可以修改外部变量）
 全局变量：直接访问（未捕获到内部，可以直接修改全局变量）
 struct __main_block_impl_0 {
     struct __block_impl impl;         //block实现方法结构体
     struct __main_block_desc_0 *Desc; //block描述信息
 }

 struct __block_impl {
     void *isa; //执行父类的isa（实例对象的isa执行父类，父类的isa执行元类，所有元类的isa执行基类的元类）
     int Flags;
     int Reserved;
     void *FuncPtr;
 }

 struct __main_block_desc_0 {
     size_t reserved;
     size_t Block_size; //block占用内存的大小
 }

 */
- (void)exampleVariableCapture {
    auto int a = 10;
    static int b = 10;
    void (^block)(void) = ^{
        NSLog(@"a:%d, b:%d, c:%d", a, b, kBlock_c);
    };
    a = 20;
    b = 20;
    kBlock_c = 20;
    
    block();
}
/*
 NSGlobalBlock (_NSConcreteGlobalBlock) 存放在数据区（全局）
 没有访问auto变量（可以访问全局变量、静态变量，只要没访问auto变量就好）
 NSStackBlock (_NSConcreteStackBlock) 存放在栈区
 mrc：访问了auto变量（自动局部变量）(arc：访问了auto，就被拷贝到堆区)
 NSMallocBlock (_NSConcreteMallocBlock) 存放在堆区
 __NSStackBlock__调用了copy函数
 
 __NSGlobalBlock__调用copy函数后，还是__NSGlobalBlock__类型
 */
- (void)exampleBlockType {
    //ARC环境下
    
    void (^block)(void) = ^{
        NSLog(@"hello");
    };
    
    NSLog(@"%@", [block class]); //__NSGlobalBlock__
    NSLog(@"%@", [[block class] superclass]); //NSBlock
    NSLog(@"%@", [[[block class] superclass] superclass]); //NSObject
    
    static int a = 10;
    void (^block1)(void) = ^{
        NSLog(@"%d", a);
    };
    NSLog(@"%@", [block1 class]); //__NSGlobalBlock__
    
    int b = 10;
    void (^block2)(void) = ^{
        NSLog(@"%d", b);
    };
    NSLog(@"%@", [block2 class]); //arc:__NSMallocBlock__, mrc:__NSStackBlock__(栈上的内存由系统管理)
}

- (void)exampleArcAutoCopy {
    static int age = 23;
    int height = 180;
    
    // 0. __NSGlobalBlock__ 未访问任何变量
    MSYBlock block0 = ^{
        NSLog(@"block0");
    };
    NSLog(@"block0:%@ p:%p", [block0 class], block0);
    
    // 1. __NSGlobalBlock__ 访问局部static变量
    MSYBlock block1 = ^{
        NSLog(@"block1 - age:%d", age);
    };
    NSLog(@"block1:%@ p:%p", [block1 class], block1);
    
    // 2. __NSGlobalBlock__ 访问全局变量
    MSYBlock block2 = ^{
        NSLog(@"block2 - kBlockWeight:%d", kBlockWeight);
    };
    NSLog(@"block2:%@ p:%p", [block2 class], block2);
    
    // 3. ARC:__NSMallocBlock__会自动从栈上复制到堆上；, MRC:__NSStackBlock__访问了auto变量
    MSYBlock block3 = ^{
        NSLog(@"block3 - height:%d", height);
    };
    NSLog(@"block3:%@ p:%p", [block3 class], block3); //block3:__NSMallocBlock__ p:0x6000024b22b0
    
    // 4. __NSMallocBlock__ 对block做了copy操作
    MSYBlock block4 = [block3 copy];
    NSLog(@"block4:%@ p:%p", [block4 class], block4); //block4:__NSMallocBlock__ p:0x6000024b22b0
    
    // 5. __NSMallocBlock__ 对block多了strong操作
    __strong MSYBlock block5 = block3;
    NSLog(@"block5:%@ p:%p", [block5 class], block5); //block5:__NSMallocBlock__ p:0x6000024b22b0
    
    /* 每种类型的block调用copy后的结果 存储域->复制效果
     _NSConcreteStackBlock 栈->从栈复制到堆
     _NSConcreteGlobalBlock 程序的数据区域->什么也不做
     _NSConcreteMallocBlock 堆->引用计数增加
     
     block copy实质做了什么？
     1.将block复制到了堆上
     2.将block中持有的auto变量复制到堆上，如果是对象就捕获其指针
     3.block->person(Block_byref)->forwarding->person对象
     
     block在arc环境下什么情况会自动copy？
     1.block作为函数返回值时
     2.将block赋值给__strong指针时
     3.block作为Cocoa API中方法名含有usingBlock的方法参数时
     4.block作为GCD API的方法参数时
     
     总结：ARC环境下，编译器根据情况自动将栈上的block复制到堆上，copy是浅拷贝，用strong和copy修饰作用相同；
     MRC环境下，block copy会把block将栈上复制到堆。
     */
}

/* __block的作用是什么？有什么使用注意点？
 __block的本质是，编译器会将__block变量包装成一个对象，然后将指针捕获到block结构体中，这样就可以在block内部持有/修改外部的auto变量。

 __block可以用于解决block内部无法修饰auto变量值的问题
 __block不能用来修饰全局变量、静态变量
 */
- (void)example__block {
    __block int age = 23;
    MSYBlock block = ^{
        NSLog(@"before:%d", age);
        age = 100;
        NSLog(@"after:%d", age);
    };
    
    block();
}

- (void)exampleResolveRetainCycle {
    __weak typeof(self) weakSelf = self;
    self.block1 = ^{
        NSLog(@"%p", weakSelf);
    };
    
    __unsafe_unretained id unsafeSelf = self;
    self.block2 = ^{
        NSLog(@"%p", unsafeSelf);
    };
    
    __block id strongSelf = self;
    self.block3 = ^{
        NSLog(@"%p", strongSelf);
        
        strongSelf = nil;
    };
    
    self.block1();
    self.block2();
    self.block3();
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
    }
    return _listView;
}

- (MSYBlockPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYBlockPresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}
@end
