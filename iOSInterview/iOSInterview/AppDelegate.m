//
//  AppDelegate.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "AppDelegate.h"
#import "MSYTabBarCtrConfig.h"

@interface AppDelegate ()

@property (nonatomic, strong) MSYTabBarCtrConfig *tabBarCtrConfig;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabBarCtrConfig = [[MSYTabBarCtrConfig alloc] init];
    
    self.window.rootViewController = self.tabBarCtrConfig.tabBarCtr;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}



@end
