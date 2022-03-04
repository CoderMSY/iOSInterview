//
//  AppDelegate.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "AppDelegate.h"
#import "MSYTabBarCtrConfig.h"
#import "YYFPSLabel.h"
#import "MSYAudioPlayer.h"

static NSString *const kBgTaskName = @"com.apple.ios.AppRunInBackground";

@interface AppDelegate ()

@property (nonatomic, strong) MSYTabBarCtrConfig *tabBarCtrConfig;
@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskIdentifier;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self hotReload];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabBarCtrConfig = [[MSYTabBarCtrConfig alloc] init];
    
    self.window.rootViewController = self.tabBarCtrConfig.tabBarCtr;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    return YES;
}

- (void)hotReload {
#ifdef DEBUG
    //InjectionIII 注入
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#else
    
#endif
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([MSYAudioPlayer sharedInstance].needRunInBackground) {
//        [[MSYAudioPlayer sharedInstance].player pause];
    }
    
    [[UIApplication sharedApplication] endBackgroundTask:self.bgTaskIdentifier];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.bgTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithName:kBgTaskName expirationHandler:^{
        if (self.bgTaskIdentifier != UIBackgroundTaskInvalid) {
            if ([MSYAudioPlayer sharedInstance].needRunInBackground) {
                if ([MSYAudioPlayer sharedInstance].player.isPlaying) {
                    [[MSYAudioPlayer sharedInstance].player play];
                }
            }
            
            [[UIApplication sharedApplication] endBackgroundTask:self.bgTaskIdentifier];
            self.bgTaskIdentifier = UIBackgroundTaskInvalid;
        }
    }];
}

@end
