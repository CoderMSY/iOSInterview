//
//  MSYMotionManager.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "MSYMotionManager.h"
#import <CoreMotion/CoreMotion.h>

@interface MSYMotionManager ()
{
    CGFloat _maxOffset;
    double _lastGravityX, _lastGravityY;
    NSTimeInterval _motionUpdateTime;//设备更新时间
    CGPoint _frontCenter; //前景图片center
    CGPoint _backCenter; //后景图片center
}

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation MSYMotionManager

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        _motionUpdateTime = 1 / 40.0;
        
    }
    return self;
}

#pragma mark - public methods

- (void)startMotion {
    if (!self.motionManager.isDeviceMotionAvailable) {
        return;
    }
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
//        [self updateGravityX:motion.gravity.x
//                    gravityY:motion.gravity.y];
    }];
}

#pragma mark - private methods

//- (void)updateGravityX:(double)gravityX
//              gravityY:(double)gravityY {
//    NSTimeInterval timeInterval = sqrt(pow((gravityX - _lastGravityX), 2) + pow((gravityY - _lastGravityY), 2)) * _motionUpdateTime;
//    NSString *animationKey = @"positionAnimationKey";
//
//    CGPoint toBackCenter = CGPointMake(self.view.center.x + gravityX * _maxOffset,
//                                       self.view.center.y + gravityY * _maxOffset);
//
//    CABasicAnimation *backIVAnimation = [[CABasicAnimation alloc] init];
//    backIVAnimation.keyPath = @"position";
//    backIVAnimation.fromValue = @(_backCenter);
//    backIVAnimation.toValue = @(toBackCenter);
//    backIVAnimation.duration = timeInterval;
//    backIVAnimation.fillMode = kCAFillModeForwards;
//    backIVAnimation.removedOnCompletion = NO;
//
//    [_backImageView.layer removeAnimationForKey:animationKey];
//    [_backImageView.layer addAnimation:backIVAnimation forKey:animationKey];
//
//    CGPoint toFrontCenter = CGPointMake(self.view.center.x - gravityX * _maxOffset,
//                                       self.view.center.y - gravityY * _maxOffset);
//    CABasicAnimation *frontIVAnimation = [[CABasicAnimation alloc] init];
//    frontIVAnimation.keyPath = @"position";
//    frontIVAnimation.fromValue = @(_frontCenter);
//    frontIVAnimation.toValue = @(toFrontCenter);
//    frontIVAnimation.duration = timeInterval;
//    frontIVAnimation.fillMode = kCAFillModeForwards;
//    frontIVAnimation.removedOnCompletion = NO;
//
//    [_frontImageView.layer removeAnimationForKey:animationKey];
//    [_frontImageView.layer addAnimation:frontIVAnimation forKey:animationKey];
//
//    _backCenter = toBackCenter;
//    _frontCenter = toFrontCenter;
//}


#pragma mark - getter && setter

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = _motionUpdateTime;
    }
    return _motionManager;
}

@end
