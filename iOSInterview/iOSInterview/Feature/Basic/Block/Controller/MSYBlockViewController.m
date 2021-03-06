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

/* block?????????????????????
 auto???????????????????????????????????????????????????????????????????????????
 static???????????????????????????????????????????????????????????????????????????
 ????????????????????????????????????????????????????????????????????????????????????
 struct __main_block_impl_0 {
     struct __block_impl impl;         //block?????????????????????
     struct __main_block_desc_0 *Desc; //block????????????
 }

 struct __block_impl {
     void *isa; //???????????????isa??????????????????isa????????????????????????isa??????????????????????????????isa????????????????????????
     int Flags;
     int Reserved;
     void *FuncPtr;
 }

 struct __main_block_desc_0 {
     size_t reserved;
     size_t Block_size; //block?????????????????????
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
 NSGlobalBlock (_NSConcreteGlobalBlock) ??????????????????????????????
 ????????????auto??????????????????????????????????????????????????????????????????auto???????????????
 NSStackBlock (_NSConcreteStackBlock) ???????????????
 mrc????????????auto??????????????????????????????(arc????????????auto????????????????????????)
 NSMallocBlock (_NSConcreteMallocBlock) ???????????????
 __NSStackBlock__?????????copy??????
 
 __NSGlobalBlock__??????copy??????????????????__NSGlobalBlock__??????
 */
- (void)exampleBlockType {
    //ARC?????????
    
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
    NSLog(@"%@", [block2 class]); //arc:__NSMallocBlock__, mrc:__NSStackBlock__(??????????????????????????????)
}

- (void)exampleArcAutoCopy {
    static int age = 23;
    int height = 180;
    
    // 0. __NSGlobalBlock__ ?????????????????????
    MSYBlock block0 = ^{
        NSLog(@"block0");
    };
    NSLog(@"block0:%@ p:%p", [block0 class], block0);
    
    // 1. __NSGlobalBlock__ ????????????static??????
    MSYBlock block1 = ^{
        NSLog(@"block1 - age:%d", age);
    };
    NSLog(@"block1:%@ p:%p", [block1 class], block1);
    
    // 2. __NSGlobalBlock__ ??????????????????
    MSYBlock block2 = ^{
        NSLog(@"block2 - kBlockWeight:%d", kBlockWeight);
    };
    NSLog(@"block2:%@ p:%p", [block2 class], block2);
    
    // 3. ARC:__NSMallocBlock__????????????????????????????????????, MRC:__NSStackBlock__?????????auto??????
    MSYBlock block3 = ^{
        NSLog(@"block3 - height:%d", height);
    };
    NSLog(@"block3:%@ p:%p", [block3 class], block3); //block3:__NSMallocBlock__ p:0x6000024b22b0
    
    // 4. __NSMallocBlock__ ???block??????copy??????
    MSYBlock block4 = [block3 copy];
    NSLog(@"block4:%@ p:%p", [block4 class], block4); //block4:__NSMallocBlock__ p:0x6000024b22b0
    
    // 5. __NSMallocBlock__ ???block??????strong??????
    __strong MSYBlock block5 = block3;
    NSLog(@"block5:%@ p:%p", [block5 class], block5); //block5:__NSMallocBlock__ p:0x6000024b22b0
    
    /* ???????????????block??????copy???????????? ?????????->????????????
     _NSConcreteStackBlock ???->??????????????????
     _NSConcreteGlobalBlock ?????????????????????->???????????????
     _NSConcreteMallocBlock ???->??????????????????
     
     block copy?????????????????????
     1.???block??????????????????
     2.???block????????????auto?????????????????????????????????????????????????????????
     3.block->person(Block_byref)->forwarding->person??????
     
     block???arc??????????????????????????????copy???
     1.block????????????????????????
     2.???block?????????__strong?????????
     3.block??????Cocoa API??????????????????usingBlock??????????????????
     4.block??????GCD API??????????????????
     
     ?????????ARC???????????????????????????????????????????????????block??????????????????copy??????????????????strong???copy?????????????????????
     MRC????????????block copy??????block????????????????????????
     */
}

/* __block????????????????????????????????????????????????
 __block??????????????????????????????__block??????????????????????????????????????????????????????block?????????????????????????????????block????????????/???????????????auto?????????

 __block??????????????????block??????????????????auto??????????????????
 __block?????????????????????????????????????????????
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
