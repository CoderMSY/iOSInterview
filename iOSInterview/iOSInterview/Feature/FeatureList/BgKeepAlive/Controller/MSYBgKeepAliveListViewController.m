//
//  MSYBgKeepAliveListViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//  参考链接：https://juejin.cn/post/6844904041680470023#heading-25

#import "MSYBgKeepAliveListViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYBgKeepAliveListDefine.h"
#import "MSYPlayAudioViewController.h"
#import "MSYProxy.h"
#import "MSYLocationManager.h"

@interface MSYBgKeepAliveListViewController () <MSYTableViewProtocol>
{
    BOOL _startLocation;
    UITableViewCell *_locationCell;
    UITableViewCell *_timerCell;
}
@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timerCount;


@end

@implementation MSYBgKeepAliveListViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    self.timerCount = 0;
    [self loadDataSource];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    //知识框架参考 https://www.jianshu.com/p/f342daf789af
    //官方 https://developer.apple.com/documentation/technologies?language=objc
    NSArray *dataList = @[
        @{
            kSec_rowContent : @[
                kBGKALTitle_map,
                kBGKALTitle_music,
                kBGKALTitle_needRunBg,
                kBGKALTitle_download,
                kBGKALTitle_timer,
            ],
        },
    ];
    
    NSMutableArray *sectionArr = [NSMutableArray array];
    for (NSDictionary *dataDic in dataList) {
        NSMutableArray *rowDicArr = [NSMutableArray array];
        NSArray *rowContent = dataDic[kSec_rowContent];
        for (NSString *title in rowContent) {
            NSDictionary *rowDic = @{
                kRow_title : title ? : @"",
            };
            
            [rowDicArr addObject:rowDic];
        }
        
        NSDictionary *sectionDic = @{
            kSec_rowContent : rowDicArr,
            kSec_headerTitle : dataDic[kSec_headerTitle] ? : @"",
            kSec_headerHeight : @(kSectionHeaderHeight_zero),
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        };
        
        [sectionArr addObject:sectionDic];
    }
    
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:sectionArr];
}

- (void)timerEvent:(id)sender {
//    NSLog(@"%s %@", __func__, sender);
    
    self.timerCount ++;
    
    if (!_timerCell) {
        _timerCell = [self getTableViewCellWithRowTitle:kBGKALTitle_timer];
    }
    
    _timerCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.timerCount];
}

- (UITableViewCell *)getTableViewCellWithRowTitle:(NSString *)title {
    for (MSYCommonTableSection *sectionModel in self.listView.dataSource) {
        for (MSYCommonTableRow *rowModel in sectionModel.rows) {
            if ([rowModel.title isEqualToString:title]) {
                NSInteger row = [sectionModel.rows indexOfObject:rowModel];
                NSInteger section = [self.listView.dataSource indexOfObject:sectionModel];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                UITableViewCell *cell = [self.listView.tableView cellForRowAtIndexPath:indexPath];
                
                return cell;
                
                break;
            }
        }
    }
    
    return nil;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
    if ([rowModel.title isEqualToString:kBGKALTitle_map]) {
        if (_startLocation) {
            _startLocation = NO;
            [[MSYLocationManager shareInstance] stopUpdatingLocation];
        }
        else {
            _startLocation = YES;
            [MSYLocationManager shareInstance].locationType = MSYLocationType_always;
            [[MSYLocationManager shareInstance] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
                CLLocationCoordinate2D coordinate = locations.firstObject.coordinate;
                
                if (!self->_locationCell) {
                    self->_locationCell = [self getTableViewCellWithRowTitle:rowModel.title];
                }
                
                self->_locationCell.detailTextLabel.text = [NSString stringWithFormat:@"latitude:%f longitude:%f", coordinate.latitude, coordinate.longitude];
                NSLog(@"%@", self->_locationCell.detailTextLabel.text);
            } failureBlock:^(NSError *error) {
                //
            }];
        }
    }
    else if ([rowModel.title isEqualToString:kBGKALTitle_music]) {
        MSYPlayAudioViewController *ctr = [[MSYPlayAudioViewController alloc] init];
        ctr.title = rowModel.title;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if ([rowModel.title isEqualToString:kBGKALTitle_needRunBg]) {
        
    }
    else if ([rowModel.title isEqualToString:kBGKALTitle_timer]) {
        if (!_timer) {
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            
            [self.timer fire];
        }
        
    }
}

#pragma mark - getter && setter


- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithCellStyle:UITableViewCellStyleSubtitle];
    }
    return _listView;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:[MSYProxy proxyWithTarget:self] selector:@selector(timerEvent:) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
