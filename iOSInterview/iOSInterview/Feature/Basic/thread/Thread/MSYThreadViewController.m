//
//  MSYThreadViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#import "MSYThreadViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import "MSYCommonTitleDetailCell.h"
#import "MSYCommonTitleDetailFrameModel.h"
#import "MSYCommonTitleImageCell.h"
#import "MSYCommonTitleImageFrameModel.h"

#import "MSYThreadDefine.h"
#import "MSYOperationFooterView.h"

@interface MSYThreadViewController () <MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYOperationFooterView *footerView;

@property (nonatomic, strong) NSIndexPath *downloadIndexPath;
@property (nonatomic, assign) NSInteger ticketSurplusCount;
@property (nonatomic, strong) NSThread *ticketSaleWindow1;
@property (nonatomic, strong) NSThread *ticketSaleWindow2;

@end

@implementation MSYThreadViewController

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
        @{
            kSec_headerTitle : @"2.1创建、启动线程",
            kSec_rowContent : @[
                kThreadTitle_initThread,
                kThreadTitle_detachNewThread,
                kThreadTitle_performSelectorInBackground,
            ],
        },
        @{
            kSec_headerTitle : @"2.2线程相关用法",
            kSec_rowContent : @[
                @{
                    kRow_title : @"获得主线程",
                    kRow_detailTitle : @"+ (NSThread *)mainThread",
                },
                @{
                    kRow_title : @"判断是否为主线程(对象方法)",
                    kRow_detailTitle : @"- (NSThread *)mainThread",
                },
                @{
                    kRow_title : @"判断是否为主线程(类方法)",
                    kRow_detailTitle : @"+ (BOOL)isMainThread",
                },
                @{
                    kRow_title : @"获得当前线程",
                    kRow_detailTitle : @"NSThread *current = [NSThread currentThread];",
                },
                @{
                    kRow_title : @"线程的名字——setter方法",
                    kRow_detailTitle : @"- (void)setName:(NSString *)n;",
                },
                @{
                    kRow_title : @"线程的名字——getter方法",
                    kRow_detailTitle : @"- (NSString *)name;",
                },
            ],
        },
        @{
            kSec_headerTitle : @"2.3 线程状态控制方法",
            kSec_rowContent : @[
                @{
                    kRow_title : @"启动线程方法",
                    kRow_detailTitle : @"// 线程进入就绪状态 -> 运行状态。当线程任务执行完毕，自动进入死亡状态 \n- (void)start;",
                },
                @{
                    kRow_title : @"阻塞（暂停）线程方法",
                    kRow_detailTitle : @"// 线程进入阻塞状态\n+ (void)sleepUntilDate:(NSDate *)date; + (void)sleepForTimeInterval:(NSTimeInterval)ti",
                },
                @{
                    kRow_title : @"强制停止线程",
                    kRow_detailTitle : @"// 线程进入死亡状态 \n+ (void)exit;",
                },
            ],
        },
        @{
            kSec_headerTitle : @"2.4 线程之间的通信",
            kSec_rowContent : @[
                @{
                    kRow_title : @"// 在主线程上执行操作",
                    kRow_detailTitle : @"- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait; \n- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray<NSString *> *)array;",
                },
                @{
                    kRow_title : @"// 在指定线程上执行操作",
                    kRow_detailTitle : @"- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray *)array NS_AVAILABLE(10_5, 2_0); \n- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait NS_AVAILABLE(10_5, 2_0);",
                },
                @{
                    kRow_title : @"// 在当前线程上执行操作，调用 NSObject 的 performSelector:相关方法",
                    kRow_detailTitle : @"- (id)performSelector:(SEL)aSelector; \n- (id)performSelector:(SEL)aSelector withObject:(id)object; \n- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;",
                },
                @{
                    kRow_title : kThreadTitle_downloadImage,
                    kRow_cellClass : NSStringFromClass([MSYCommonTitleImageCell class]),
                },
            ],
        },
        @{
            kSec_headerTitle : @"2.5 NSThread 线程安全和线程同步",
            kSec_rowContent : @[
                kThreadTitle_threadSafe,
            ],
        },
        @{
            kSec_headerTitle : @"2.6 线程的状态转换",
            kSec_rowContent : @[
                @{
                    kRow_title : @"当前线程的状态转换",
                    kRow_detailTitle : @"如果CPU现在调度当前线程对象，则当前线程对象进入运行状态，如果CPU调度其他线程对象，则当前线程对象回到就绪状态。 \n如果CPU在运行当前线程对象的时候调用了sleep方法/等待同步锁，则当前线程对象就进入了阻塞状态，等到sleep到时/得到同步锁，则回到就绪状态。 \n如果CPU在运行当前线程对象的时候线程任务执行完毕/异常强制退出，则当前线程对象进入死亡状态。",
                },
            ],
        },
        
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (id obj in rowContent) {
            NSDictionary *rowDic;
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)obj;
                
                NSString *title = dic[kRow_title];
                if ([title isEqualToString:kThreadTitle_downloadImage]) {
                    MSYCommonTitleImageFrameModel *fModel = [[MSYCommonTitleImageFrameModel alloc] init];
                    fModel.title = title = title;
                    rowDic = @{
                        kRow_extraInfo : fModel,
                        kRow_title : fModel.title ? : @"",
                        kRow_rowHeight : @(fModel.cellHeight),
                        kRow_cellClass : dic[kRow_cellClass] ? : @"",
                    };
                }
                else {
                    MSYCommonTitleDetailFrameModel *fModel = [[MSYCommonTitleDetailFrameModel alloc] init];
                    fModel.title = dic[kRow_title];
                    fModel.detail = dic[kRow_detailTitle];
                    
                    rowDic = @{
                        kRow_extraInfo : fModel,
                        kRow_title : fModel.title ? : @"",
                        kRow_rowHeight : @(fModel.cellHeight),
                        kRow_cellClass : NSStringFromClass([MSYCommonTitleDetailCell class]),
                    };
                }
            }
            else {
                rowDic = @{
                    kRow_title : obj ? : @"",
                };
            }
            
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

- (void)initThread {
    // 1. 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runWithName:) object:@"initThread"];
    // 2. 启动线程
    [thread start];    // 线程一启动，就会在线程thread中执行self的run方法
}

- (void)detachNewThread {
    //创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(runWithName:) toTarget:self withObject:@"detachNewThread"];
}

- (void)performSelectorInBackground {
    //隐式创建并启动线程
    [self performSelectorInBackground:@selector(runWithName:) withObject:@"performSelectorInBackground"];
}

// 新线程调用方法，里边为需要执行的任务
- (void)runWithName:(NSString *)name {
     NSLog(@"%s---name:%@---%@", __func__, name, [NSThread currentThread]);
}

#pragma mark - downloadImage
/**
 * 创建一个线程下载图片
 */
- (void)downloadImageOnSubThread {
    // 在创建的子线程中调用downloadImage下载图片
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}

/**
 * 下载图片，下载完之后回到主线程进行 UI 刷新
 */
- (void)downloadImage {
    NSLog(@"current thread -- %@", [NSThread currentThread]);
    
    // 1. 获取图片 imageUrl
    NSURL *imageUrl = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1907928680,2774802011&fm=26&gp=0.jpg"];
    
    // 2. 从 imageUrl 中读取数据(下载图片) -- 耗时操作
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    // 通过二进制 data 创建 image
    UIImage *image = [UIImage imageWithData:imageData];
    
    // 3. 回到主线程进行图片赋值和界面刷新
    [self performSelectorOnMainThread:@selector(refreshOnMainThread:) withObject:image waitUntilDone:YES];
}

/**
 * 回到主线程进行图片赋值和界面刷新
 */
- (void)refreshOnMainThread:(UIImage *)image {
    NSLog(@"current thread -- %@", [NSThread currentThread]);
    
    // 赋值图片到imageview
    
    if (self.downloadIndexPath) {
        MSYCommonTableSection *sectionModel = self.listView.dataSource[self.downloadIndexPath.section];
        MSYCommonTableRow *rowModel = sectionModel.rows[self.downloadIndexPath.row];
        if ([rowModel.extraInfo isKindOfClass:[MSYCommonTitleImageFrameModel class]]) {
            MSYCommonTitleImageFrameModel *fModel = (MSYCommonTitleImageFrameModel *)rowModel.extraInfo;
            fModel.image = image;
            
            rowModel.uiRowHeight = fModel.cellHeight;
            [self.listView reloadRowsInCommonViewAtIndexPaths:@[self.downloadIndexPath]];
        }
        
    }
}

#pragma mark - Ticket Sale

/**
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 设置北京火车票售卖窗口的线程
    self.ticketSaleWindow1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWindow1.name = @"北京火车票售票窗口";
    
    // 3. 设置上海火车票售卖窗口的线程
    self.ticketSaleWindow2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWindow2.name = @"上海火车票售票窗口";
    
    // 4. 开始售卖火车票
    [self.ticketSaleWindow1 start];
    [self.ticketSaleWindow2 start];
    
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        // 互斥锁
        @synchronized (self) {
            //如果还有票，继续售卖
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
    }
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kThreadTitle_initThread]) {
        [self initThread];
    }
    else if ([rowModel.title isEqualToString:kThreadTitle_detachNewThread]) {
        [self detachNewThread];
    }
    else if ([rowModel.title isEqualToString:kThreadTitle_performSelectorInBackground]) {
        [self performSelectorInBackground];
    }
    else if ([rowModel.title isEqualToString:kThreadTitle_downloadImage]) {
        self.downloadIndexPath = indexPath;
        [self downloadImageOnSubThread];
    }
    else if ([rowModel.title isEqualToString:kThreadTitle_threadSafe]) {
        [self initTicketStatusSave];
    }
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
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
