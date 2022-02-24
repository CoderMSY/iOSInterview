//
//  MSYOpenHole3DBannerViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "MSYOpenHole3DBannerViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <Masonry/Masonry.h>
#import <MSYCategory/UIView+MSYHelper.h>

#import "MSYOpenHole3DBannerView.h"

@interface MSYOpenHole3DBannerViewController ()
{
    NSTimeInterval _motionUpdateTime;//设备更新时间
}
@property (nonatomic, strong) MSYOpenHole3DBannerView *bannerView;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation MSYOpenHole3DBannerViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _motionUpdateTime = 1 / 40.0;
    [self.view addSubview:self.bannerView];
    
    [self initConstraints];
    [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startMotion];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.motionManager stopDeviceMotionUpdates];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat banner_h = 383.0 / 900.0 * screen_w;
    CGFloat top = [UIView msy_getSafeAreaTop] + self.navigationController.navigationBar.frame.size.height;
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(top);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(banner_h);
    }];
}

- (void)loadDataSource {
    NSMutableArray *bannerList = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:@"banner_back"];
        [bannerList addObject:image];
    }
    self.bannerView.bannerList = bannerList;
}

- (void)startMotion {
    if (!self.motionManager.isDeviceMotionAvailable) {
        return;
    }
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        [self.bannerView updateGravityX:motion.gravity.x
                               gravityY:motion.gravity.y];
    }];
}

#pragma mark - getter && setter

- (MSYOpenHole3DBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[MSYOpenHole3DBannerView alloc] init];
    }
    return _bannerView;
}


- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = _motionUpdateTime;
    }
    return _motionManager;
}

@end
