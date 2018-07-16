//
//  BATabBarControllerConfig.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BATabBarControllerConfig.h"
#import "CYLTabBarController.h"
#import "BANavigationController.h"
#import "BAHomeController.h"
#import "BANewsController.h"
#import "BAMeController.h"

@interface BATabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation BATabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        _tabBarController.selectedIndex = 1;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    BANewsController *firstViewController = [[BANewsController alloc] init];
    UIViewController *firstNavigationController = [[BANavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    BAHomeController *secondViewController = [[BAHomeController alloc] init];
    UIViewController *secondNavigationController = [[BANavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    BAMeController *thirdViewController = [[BAMeController alloc] init];
    UIViewController *thirdNavigationController = [[BANavigationController alloc]
                                                   initWithRootViewController:thirdViewController];

    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"xiaoxi_un",
                            CYLTabBarItemSelectedImage : @"xiaoxi_sel"
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"猪管家",
                            CYLTabBarItemImage : @"gongzuotai_un",
                            CYLTabBarItemSelectedImage : @"gongzuotai_sel"
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"wode_un",
                            CYLTabBarItemSelectedImage : @"wode_sel"
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    UITabBar *tabBarAppearance = [UITabBar appearance];
    tabBarAppearance.translucent = NO;
    tabBarAppearance.barTintColor = [UIResource getffffffColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIResource geta6a2a3Color], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIResource get0faae2Color], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
