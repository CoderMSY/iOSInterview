//
//  MSYOpenHole3DViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "MSYOpenHole3DViewController.h"
#import <Masonry/Masonry.h>
#import <CoreMotion/CoreMotion.h>

@interface MSYOpenHole3DViewController ()
{
    CGFloat _maxOffset;
    double _lastGravityX, _lastGravityY;
    NSTimeInterval _motionUpdateTime;//设备更新时间
    CGPoint _frontCenter;
    CGPoint _backCenter;
}
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation MSYOpenHole3DViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _maxOffset = 30.0;
    _lastGravityX = 0;
    _lastGravityY = 0;
    
    _motionUpdateTime = 1 / 40.0;
    _frontCenter = CGPointZero;
    _backCenter = CGPointZero;
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.middleImageView];
    [self.view addSubview:self.frontImageView];
    [self initConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startMotion];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _frontCenter = self.view.center;
    _backCenter = self.view.center;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(_maxOffset * 2);
        make.height.mas_equalTo(self.view).offset(_maxOffset * 2);
    }];
    [self.middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(_maxOffset * 2);
        make.height.mas_equalTo(self.view).offset(_maxOffset * 2);
    }];
}

- (void)startMotion {
    if (!self.motionManager.isDeviceMotionAvailable) {
        return;
    }
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        [self updateGravityX:motion.gravity.x
                    gravityY:motion.gravity.y];
    }];
}

- (void)updateGravityX:(double)gravityX
              gravityY:(double)gravityY {
    NSTimeInterval timeInterval = sqrt(pow((gravityX - _lastGravityX), 2) + pow((gravityY - _lastGravityY), 2)) * _motionUpdateTime;
    NSString *animationKey = @"positionAnimationKey";
    
    CGPoint toBackCenter = CGPointMake(self.view.center.x + gravityX * _maxOffset,
                                       self.view.center.y + gravityY * _maxOffset);
    
    CABasicAnimation *backIVAnimation = [[CABasicAnimation alloc] init];
    backIVAnimation.keyPath = @"position";
    backIVAnimation.fromValue = @(_backCenter);
    backIVAnimation.toValue = @(toBackCenter);
    backIVAnimation.duration = timeInterval;
    backIVAnimation.fillMode = kCAFillModeForwards;
    backIVAnimation.removedOnCompletion = NO;
    
    [_backImageView.layer removeAnimationForKey:animationKey];
    [_backImageView.layer addAnimation:backIVAnimation forKey:animationKey];
    
    CGPoint toFrontCenter = CGPointMake(self.view.center.x - gravityX * _maxOffset,
                                       self.view.center.y - gravityY * _maxOffset);
    CABasicAnimation *frontIVAnimation = [[CABasicAnimation alloc] init];
    frontIVAnimation.keyPath = @"position";
    frontIVAnimation.fromValue = @(_frontCenter);
    frontIVAnimation.toValue = @(toFrontCenter);
    frontIVAnimation.duration = timeInterval;
    frontIVAnimation.fillMode = kCAFillModeForwards;
    frontIVAnimation.removedOnCompletion = NO;
    
    [_frontImageView.layer removeAnimationForKey:animationKey];
    [_frontImageView.layer addAnimation:frontIVAnimation forKey:animationKey];
    
    _backCenter = toBackCenter;
    _frontCenter = toFrontCenter;
}

#pragma mark - getter && setter

- (UIImageView *)frontImageView {
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc] init];
        _frontImageView.image = [UIImage imageNamed:@"screen_front"];
        _frontImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _frontImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.image = [UIImage imageNamed:@"screen_mid"];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _middleImageView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"screen_back"];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = _motionUpdateTime;
    }
    return _motionManager;
}

@end
