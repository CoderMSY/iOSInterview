//
//  MSYAbstractFactoryViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//
/*
 https://www.runoob.com/design-pattern/abstract-factory-pattern.html
 抽象工厂模式（Abstract Factory Pattern）是围绕一个超级工厂创建其他工厂。该超级工厂又称为其他工厂的工厂。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

 抽象工厂模式:每个抽象工厂派生多个具体工厂类，每个具体工厂负责多个（一系列）具体产品的实例创建。

 */
#import "MSYAbstractFactoryViewController.h"
#import "MSYAbstractFactory.h"

@interface MSYAbstractFactoryViewController ()

@end

@implementation MSYAbstractFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self abstractFactory];
}

- (void)abstractFactory {
    MSYAbstractFactory *factory = [[MSYAbstractFactory alloc] init];
    MSYBaseCarImpl *benzImpl = [factory getCarImplWithType:MSYAbstractFactoryType_benz];
    MSYCar *sportCar = [benzImpl createSportCar];
    [sportCar drive];
    
    MSYBaseCarImpl *audiImpl = [factory getCarImplWithType:MSYAbstractFactoryType_audi];
    MSYCar *audiBusinessCar = [audiImpl createBusinessCar];
    [audiBusinessCar drive];
}

@end
