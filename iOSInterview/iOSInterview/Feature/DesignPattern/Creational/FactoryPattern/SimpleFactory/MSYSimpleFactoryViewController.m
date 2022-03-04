//
//  MSYSimpleFactoryViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

/** 简单工厂模式
 可以根据参数的不同返回不同类的实例。
 简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。
 */
#import "MSYSimpleFactoryViewController.h"
#import "MSYSimpleFactory.h"

@interface MSYSimpleFactoryViewController ()

@end

@implementation MSYSimpleFactoryViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MSYSimpleFactory *factory = [MSYSimpleFactory simpleFactory];
    MSYCar *benzBusinessCar = [factory createCarWithType:MSYCarType_benzBusiness];
    [benzBusinessCar drive];
    
    MSYCar *bmwSportCar = [factory createCarWithType:MSYCarType_bmwSport];
    [bmwSportCar drive];
    
    MSYCar *audiSportCar = [factory createCarWithType:MSYCarType_audiSport];
    [audiSportCar drive];
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - getter && setter

@end
