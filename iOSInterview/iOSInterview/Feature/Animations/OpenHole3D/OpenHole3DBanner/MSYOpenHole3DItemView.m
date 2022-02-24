//
//  MSYOpenHole3DItemView.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "MSYOpenHole3DItemView.h"
#import <Masonry/Masonry.h>
//#import <CoreMotion/CoreMotion.h>

@interface MSYOpenHole3DItemView ()
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

//@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation MSYOpenHole3DItemView

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxOffset = 30.0;
        _lastGravityX = 0;
        _lastGravityY = 0;
        
        _motionUpdateTime = 1 / 40.0;
        _frontCenter = CGPointZero;
        _backCenter = CGPointZero;
        
        [self addSubview:self.backImageView];
        [self addSubview:self.middleImageView];
        [self addSubview:self.frontImageView];
        
        [self initConstraints];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    _frontCenter = self.center;
//    _backCenter = self.center;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self).offset(_maxOffset * 2);
        make.height.mas_equalTo(self).offset(_maxOffset * 2);
    }];
    [self.middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self).offset(_maxOffset * 2);
        make.height.mas_equalTo(self).offset(_maxOffset * 2);
    }];
}

- (void)updateGravityX:(double)gravityX
              gravityY:(double)gravityY {
    NSTimeInterval timeInterval = sqrt(pow((gravityX - _lastGravityX), 2) + pow((gravityY - _lastGravityY), 2)) * _motionUpdateTime;
    NSString *animationKey = @"positionAnimationKey";
    
    CGPoint toBackCenter = CGPointMake(self.center.x + gravityX * _maxOffset,
                                       self.center.y + gravityY * _maxOffset);
    
    CABasicAnimation *backIVAnimation = [[CABasicAnimation alloc] init];
    backIVAnimation.keyPath = @"position";
    backIVAnimation.fromValue = @(_backCenter);
    backIVAnimation.toValue = @(toBackCenter);
    backIVAnimation.duration = timeInterval;
    backIVAnimation.fillMode = kCAFillModeForwards;
    backIVAnimation.removedOnCompletion = NO;
    
    [_backImageView.layer removeAnimationForKey:animationKey];
    [_backImageView.layer addAnimation:backIVAnimation forKey:animationKey];
    
    CGPoint toFrontCenter = CGPointMake(self.center.x - gravityX * _maxOffset,
                                       self.center.y - gravityY * _maxOffset);
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
        _frontImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _frontImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _middleImageView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

@end
