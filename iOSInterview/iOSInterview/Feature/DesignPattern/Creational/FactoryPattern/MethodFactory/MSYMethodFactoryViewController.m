//
//  MSYMethodFactoryViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/4.
//

/* 工厂方法模式
 工厂方法模式是简单工厂的进一步深化，在工厂方法模式中，不再提供一个统一的工厂类来创建所有的对象，而是针对不同的对象提供不同的工厂。也就是说每个对象都有一个与之对应的工厂。

 定义一个创建对象的接口，但让实现这个接口的类来决定实例化哪个类。工厂方法让类的实例化推迟到子类中进行
 */
#import "MSYMethodFactoryViewController.h"
#import "MSYBenzFactory.h"
#import "MSYBmwFactory.h"
#import "MSYAudiFactory.h"

@interface MSYMethodFactoryViewController ()

@end

@implementation MSYMethodFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MSYBenzFactory *benzFactory = [MSYBenzFactory methodFactory];
    MSYCar *benzSportCar = [benzFactory createSportCar];
    [benzSportCar drive];
    
    MSYBmwFactory *bmwFactory = [MSYBmwFactory methodFactory];
    MSYCar *bmwBusinessCar = [bmwFactory createBusinessCar];
    [bmwBusinessCar drive];
    
    MSYAudiFactory *audiFactory = [MSYAudiFactory methodFactory];
    MSYCar *audiSportCar = [audiFactory createSportCar];
    [audiSportCar drive];
}

@end
