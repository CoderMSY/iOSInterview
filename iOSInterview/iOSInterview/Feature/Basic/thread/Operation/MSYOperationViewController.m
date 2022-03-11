//
//  MSYOperationViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/17.
//

#import "MSYOperationViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYOperation.h"
#import "MSYOperationQueueHandleCell.h"
#import "MSYOperationFooterView.h"

@interface MSYOperationViewController () <MSYTableViewProtocol, MSYOperationQueueHandleCellProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYOperationFooterView *footerView;

@property (nonatomic, strong) NSOperationQueue *handleQueue;


@end

@implementation MSYOperationViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSArray *dataList = @[
        @"NSInvocationOperation",
        @"NSBlockOperation",
        @"自定义子类继承NSOperation",
        @"NSOperationQueue",
        @"NSOperationQueue、NSBlockOperation组合使用",
        @"maxConcurrent",
        @"handle queue",
        @"operation dependency",
        @"NSOperation 线程间通信 (案例：下载图片及合成)",
    ];
    NSMutableArray *rowDicArr = [NSMutableArray array];
    for (NSString *title in dataList) {
        NSDictionary *rowDic;
        if ([title isEqualToString:@"handle queue"]) {
            rowDic = @{
                kRow_cellClass : NSStringFromClass([MSYOperationQueueHandleCell class]),
            };
        }
        else {
            rowDic = @{
                kRow_title : title,
            };
        }
        
        [rowDicArr addObject:rowDic];
    }
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowDicArr,
        kSec_headerHeight : @(kSectionHeaderHeight_zero),
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
    };
    
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:@[sectionDic]];
}

#pragma mark - NSInvocationOperation

- (void)invocationOperation {
    NSLog(@"-------- %s --------", __func__);
    //1.创建任务， object：如selector接收的方法参数
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation2) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation3) object:nil];
    /* 启动任务
     结果：在主线程上，串行执行任务
     */
    [op1 start];
    [op2 start];
    [op3 start];
}

- (void)invocationOperation1 {
    NSLog(@"%s--%@", __func__, [NSThread currentThread]);
}

- (void)invocationOperation2 {
    NSLog(@"%s--%@", __func__, [NSThread currentThread]);
}

- (void)invocationOperation3 {
    NSLog(@"%s--%@", __func__, [NSThread currentThread]);
}

#pragma mark - NSBlockOperation

- (void)blockOperation {
    NSLog(@"-------- %s --------", __func__);
    
    //1.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    
    /* 追加任务
    追加任务，导致op3会并行执行任务，追加的任务不一定是在子线程，也可能会主线程
     结果：1、2是主线程串行执行，3、4、5、6执行并行执行，线程不可控
    */
    [op3 addExecutionBlock:^{
        NSLog(@"4---%@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"5---%@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"6---%@", [NSThread currentThread]);
    }];
    
    //2.启动
    [op1 start];
    [op2 start];
    [op3 start];
}

#pragma mark - MSYOperation

- (void)customOperation {
    NSLog(@"-------- %s --------", __func__);
    
    MSYOperation *op1 = [[MSYOperation alloc] init];
    MSYOperation *op2 = [[MSYOperation alloc] init];
    MSYOperation *op3 = [[MSYOperation alloc] init];
    
    [op1 start];
    [op2 start];
    [op3 start];
}

#pragma mark - NSOperationQueue

- (void)invokeOperationWithQueue {
    NSLog(@"-------- %s --------", __func__);
    //1.创建任务， object：如selector接收的方法参数
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation2) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation3) object:nil];
    
    /* 2.创建队列：默认是异步执行的
    主队列：[NSOperationQueue mainQueue]
    非主队列：NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    */
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    //3.添加操作到队列中，addOperation内部已经调用了[op1 start]，不需要再手动启动
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)blockOperationWithQueue {
    NSLog(@"-------- %s --------", __func__);
    
    //1.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    
    /* 追加任务
    追加任务，导致op3会并行执行任务，追加的任务不一定是在子线程，也可能会主线程
     结果：1、2是主线程串行执行，3、4、5、6执行并行执行，线程不可控
    */
    [op3 addExecutionBlock:^{
        NSLog(@"4---%@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"5---%@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"6---%@", [NSThread currentThread]);
    }];
    
    //3.添加操作到队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    [queue addOperationWithBlock:^{
        NSLog(@"7---%@", [NSThread currentThread]);
    }];
    //结果：任务都是并发执行的
}

- (void)maxConcurrent {
    NSLog(@"-------- %s --------", __func__);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    /* 同一时间设置最多有几个任务在执行
     > 1： 并行队列
     == 1： 串行队列 (并不代表只开一条线程)(线程同步)
     == 0 不会执行任务
     == -1 最大值, 表示不受限制
     */
    queue.maxConcurrentOperationCount = 1;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4---%@", [NSThread currentThread]);
    }];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}
#pragma mark - addDependency
- (void)dependencyTest {
    NSLog(@"-------- %s --------", __func__);
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    //操作监听 （监听操作不一定与被监听的任务属于同一线程，）
    op3.completionBlock = ^{
        NSLog(@"3已经执行完毕--------%@", [NSThread currentThread]);
    };
    
    /* 依赖优先级:op3 > op1 > op2,
     1.不可相互依赖
     */
    [op1 addDependency:op3];//op1 依赖于 op3
    [op2 addDependency:op1];
    
    //跨队列依赖
    [queue1 addOperation:op1];
    [queue1 addOperation:op2];
    [queue2 addOperation:op3];
}

#pragma mark - 线程通信

- (void)downloadImage {
    __block UIImage *image1;
    __block UIImage *image2;
    
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //2.封装操作下载图片1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1907928680,2774802011&fm=26&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //拿到图片数据
        image1 = [UIImage imageWithData:data];
    }];
    
    
    //3.封装操作下载图片2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1412439743,1735171648&fm=26&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //拿到图片数据
        image2 = [UIImage imageWithData:data];
    }];
    
    //4.合成图片
    NSBlockOperation *drawOp = [NSBlockOperation blockOperationWithBlock:^{
        
        CGFloat image_w = 200;
        CGFloat image_h = 300;
        //4.1 开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(image_w, image_h));
        
        //4.2 画image1
        [image1 drawInRect:CGRectMake(0, 0, image_w / 2, image_h)];
        
        //4.3 画image2
        [image2 drawInRect:CGRectMake(image_w / 2, 0, image_w / 2, image_h)];
        
        //4.4 根据图形上下文拿到图片数据
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //        NSLog(@"%@",image);
        
        //4.5 关闭图形上下文
        UIGraphicsEndImageContext();
        
        //7.回到主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.footerView.iconIV.image = image;
            NSLog(@"刷新UI---%@",[NSThread currentThread]);
        }];
        
    }];
    
    //5.设置操作依赖
    [drawOp addDependency:op1];
    [drawOp addDependency:op2];
    
    //6.添加操作到队列中执行
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:drawOp];
}

#pragma mark - MSYOperationQueueHandleCellProtocol

- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell startBtnClicked:(UIButton *)sender {
    if (!_handleQueue) {
        self.handleQueue = [[NSOperationQueue alloc] init];
        self.handleQueue.maxConcurrentOperationCount = 1;
        
        MSYOperation *op1 = [[MSYOperation alloc] init];
        op1.name = @"op1";
        MSYOperation *op2 = [[MSYOperation alloc] init];
        op2.name = @"op2";
        
        [self.handleQueue addOperation:op1];
        [self.handleQueue addOperation:op2];
    }
}

- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell suspendBtnClicked:(UIButton *)sender {
    /* YES表示暂停队列，NO代表恢复队列
     暂停表示当前执行任务不会立即取消，而是后面的任务不会继续执行
    */
    [_handleQueue setSuspended:YES];
}

- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell continueBtnClicked:(UIButton *)sender {
    [_handleQueue setSuspended:NO];
}
- (void)operationQueueHandleCell:(MSYOperationQueueHandleCell *)cell cancelBtnClicked:(UIButton *)sender {
    //退出所有操作, 当前执行的任务不会立即取消，而是后面的任务永远不会继续执行
    [_handleQueue cancelAllOperations];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        [self invocationOperation];
    }
    else if (1 == indexPath.row) {
        [self blockOperation];
    }
    else if (2 == indexPath.row) {
        [self customOperation];
    }
    else if (3 == indexPath.row) {
        [self invokeOperationWithQueue];
    }
    else if (4 == indexPath.row) {
        [self blockOperationWithQueue];
    }
    else if (5 == indexPath.row) {
        [self maxConcurrent];
    }
    else if (7 == indexPath.row) {
        [self dependencyTest];
    }
    else if (8 == indexPath.row) {
        [self downloadImage];
    }
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
        [_listView setTableFooterView:self.footerView];
    }
    return _listView;
}

- (MSYOperationFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[MSYOperationFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 350)];
    }
    return _footerView;
}

@end
