//
//  MSYTabBarCtrConfig.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "MSYTabBarCtrConfig.h"
#import "MSYAlgorithmViewController.h"

static NSString *const kTBItemTitle = @"title";
static NSString *const kTBItemImage = @"image";
static NSString *const kTBItemSelectedImage = @"selectedImage";

@interface MSYTabBarCtrConfig () <UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) UITabBarController *tabBarCtr;

@end

@implementation MSYTabBarCtrConfig

#pragma mark - lifecycle methods


#pragma mark - public methods

- (UITabBarController *)tabBarCtr {
    if (!_tabBarCtr) {
        _tabBarCtr = [[UITabBarController alloc] init];
        _tabBarCtr.delegate = self;
        _tabBarCtr.viewControllers = [self viewControllers];
        NSNumber *selectedIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"kTabBarSelectedIndex"];
        _tabBarCtr.selectedIndex = selectedIndex.unsignedIntValue;
        
        UIImageView *bgIV = [self createTabbarBgIV];
        [_tabBarCtr.tabBar addSubview:bgIV];
        [_tabBarCtr.tabBar insertSubview:bgIV atIndex:0];
         //去除顶部横线
        [_tabBarCtr.tabBar setBackgroundImage:[UIImage new]];
        [_tabBarCtr.tabBar setShadowImage:[UIImage new]];
        _tabBarCtr.tabBar.barStyle = UIBarStyleDefault;
    }
    
    return _tabBarCtr;
}

#pragma mark - private methods

- (CGFloat)getTabbarSafeBottomMargin {
    CGFloat safeBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return safeBottom;
}

- (UIImageView *)createTabbarBgIV {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"tabbar_bg"];
    // 拉伸图片
    UIImage *bgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIImageView *bgIV = [[UIImageView alloc] initWithImage:bgImage];
    bgIV.contentMode = UIViewContentModeScaleToFill;
    CGFloat tabBarHeight = [self getTabbarSafeBottomMargin] + 49;
    CGFloat bgIV_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat width_scale = [UIScreen mainScreen].bounds.size.width / 375;
    bgIV.frame = CGRectMake(0, -20 * width_scale, bgIV_w, tabBarHeight + 20 * width_scale);
    
    return bgIV;
}

- (NSArray *)viewControllers {
    NSArray *attributes = [self tabBarItemsAttributes];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < attributes.count; i ++) {
        UIViewController *ctr;
        if (0 == i) {
            ctr = [[MSYAlgorithmViewController alloc] init];
//            ctr = [[CTMediator sharedInstance] homeViewControllerWithCallback:^(NSString * _Nonnull result) {
//                NSLog(@"%@", result);
//            }];
        }
        else if (1 == i) {
//            ctr = [[CTMediator sharedInstance] loveSeeViewCtr];
//            ctr = [[CTMediator sharedInstance] miguHomeCtrWithParams:[NSDictionary dictionary]];
        }
        else if (2 == i) {
//            ctr = [[CTMediator sharedInstance] shoppingViewCtr];
        }
        else if (3 == i) {
//            ctr = [[CTMediator sharedInstance] tidePlayViewCtr];
        }
        else if (4 == i) {
//            ctr = [[CTMediator sharedInstance] B_viewControllerWithContentText:@"hello NBA"];
            NSDictionary *myParams = @{
                @"userName" : @"Mercy",
                @"userId" : @"123"
            };
//            ctr = [[CTMediator sharedInstance] myViewCtrWithParams:myParams callback:^(NSString * _Nonnull result) {
//                NSLog(@"%@", result);
//            }];
        }
        
        if (!ctr) {
//            continue;
            ctr = [[UIViewController alloc] init];
        }
        
        NSDictionary *dic = attributes[i];
        ctr.tabBarItem.title = dic[kTBItemTitle];
        ctr.tabBarItem.image = [[UIImage imageNamed:dic[kTBItemImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ctr.tabBarItem.selectedImage = [[UIImage imageNamed:dic[kTBItemSelectedImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:ctr];
        [viewControllers addObject:navCtr];
    }
    
    return viewControllers;
}


- (NSArray *)tabBarItemsAttributes {
    NSDictionary *firstItemsAttributes = @{
        kTBItemTitle : @"首页",
        kTBItemImage : @"home_normal",  /* NSString and UIImage are supported*/
        kTBItemSelectedImage : @"home_highlight"  /* NSString and UIImage are supported*/
    };
    NSDictionary *secondItemsAttributes = @{
        kTBItemTitle : @"爱看",
        kTBItemImage : @"fishpond_normal",
        kTBItemSelectedImage : @"fishpond_highlight"
    };
    
    NSDictionary *thirdItemsAttributes = @{
        kTBItemTitle : @"商城",
        kTBItemImage : @"message_normal",
        kTBItemSelectedImage : @"message_highlight"
    };
    NSDictionary *fourthItemsAttributes = @{
        kTBItemTitle : @"潮玩",
        kTBItemImage : @"account_normal",
        kTBItemSelectedImage : @"account_highlight"
    };
    NSArray *tabBarItemsAttributes = @[
        firstItemsAttributes,
        secondItemsAttributes,
        thirdItemsAttributes,
        fourthItemsAttributes
    ];
    return tabBarItemsAttributes;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"selectedIndex:%ld", tabBarController.selectedIndex);
    [[NSUserDefaults standardUserDefaults] setObject:@(tabBarController.selectedIndex) forKey:@"kTabBarSelectedIndex"];
}

#pragma mark - getter && setter

@end
