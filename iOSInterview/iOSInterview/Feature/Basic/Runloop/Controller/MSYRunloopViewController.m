//
//  MSYRunloopViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#import "MSYRunloopViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYRunloopPresenter.h"
#import "MSYPermanantThread.h"
#import "MSYCFPermanantThread.h"
#import "MSYLagMonitor.h"

@interface MSYRunloopViewController () <MSYPresenterCommonOutput, MSYTableViewProtocol>

@property (nonatomic, strong) MSYRunloopPresenter *presenter;
@property (nonatomic, strong) MSYCommonTableView *listView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) MSYPermanantThread *thread;
@property (nonatomic, strong) MSYCFPermanantThread *cfThread;

@end

@implementation MSYRunloopViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Runloop";
    
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self.presenter fetchDataSource];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [_timer invalidate];
    
    [[MSYLagMonitor shareInstance] endMonitor];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)threadMethod {
    [self.thread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (void)threadCFRunLoopMethod {
    [self.cfThread executeTask:^{
        NSLog(@"执行任务 CFRunLoop线程保活 - %@", [NSThread currentThread]);
    }];
}

- (void)timerMethod {
    if (!_timer) {
        //NSDefaultRunLoopMode: 默认模式
        //UITrackingRunLoopMode: 滚动模式
        //NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
        //timer能在_commonModes数组中存放的模式下工作
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        /* 用户不操作时，RunLoop处于NSDefaultRunLoopMode，
           用户拖动UI时，RunLoop就结束NSDefaultRunLoopMode，切换到UITrackingRunLoopMode模式，这个模式下NSTimer就不工作了
           用户取消UI拖动，又切换到NSDefaultRunLoopMode模式
         */
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    else {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - MSYPresenterCommonOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kRowRunloop_thead]) {
        [self threadMethod];
    }
    else if ([rowModel.title isEqualToString:kRowRunloop_thead_CFRunLoop]) {
        [self threadCFRunLoopMethod];
    }
    else if ([rowModel.title isEqualToString:kRowRunloop_timer]) {
        [self timerMethod];
    }
    else if ([rowModel.title isEqualToString:kRowRunloop_monitorPerformanceLag]) {
        [[MSYLagMonitor shareInstance] beginMonitor];
    }
    else if ([rowModel.title isEqualToString:kRowRunloop_mainThreadStuck]) {
        NSLog(@"卡顿测试");
        //usleep：单位为微妙 1秒=1000毫秒=1000000微妙 sleep：单位为秒
        usleep(20 * 1000); //20毫秒
    }
    else if ([rowModel.title isEqualToString:kRowRunloop_performanceOptimization]) {
        [self.presenter pushRunLoopImageWithTitle:rowModel.title];
    }
}

#pragma mark - getter && setter

- (MSYRunloopPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYRunloopPresenter alloc] init];
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

- (NSTimer *)timer {
    if (!_timer) {
        static int count = 0;
        if (@available(iOS 10.0, *)) {
            _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSLog(@"%d", ++count);
            }];
            
            //scheduledTimer 初始化的方法，NSTimer会自动被加入NSDefaultRunLoopMode模式
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                NSLog(@"%d", ++count);
//            }];
        } else {
            // Fallback on earlier versions
        }
    }
    return _timer;
}

- (MSYPermanantThread *)thread {
    if (!_thread) {
        _thread = [[MSYPermanantThread alloc] init];
    }
    return _thread;
}

- (MSYCFPermanantThread *)cfThread {
    if (!_cfThread) {
        _cfThread = [[MSYCFPermanantThread alloc] init];
    }
    return _cfThread;
}

@end
