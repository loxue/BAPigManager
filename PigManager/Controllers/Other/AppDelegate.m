//
//  AppDelegate.m
//  365
//  马彦春
//  Created by imac on 2018/5/24.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "AppDelegate.h"
#import "BAStartGuideViewController.h"
#import "BALoginController.h"
#import "BAMeController.h"

CFAbsoluteTime StartTime;

@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"完成启动---->%f", CFAbsoluteTimeGetCurrent());
        NSLog(@"启动用时---->%f", CFAbsoluteTimeGetCurrent()-StartTime);
    });
    [NSThread sleepForTimeInterval:1.0];
    
    // 获取设备的UID
    [self getDeviceUid];
    
    // 加载windown
    [self loadWindow];
    
    return YES;
}

- (NSString *)getDeviceUid {
    NSString *uuidStr = [NSString stringWithFormat:@"%@", [[UIDevice currentDevice] identifierForVendor]];
    NSString *finalStr = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [UserDefaults setObject:finalStr forKey:UUIDSTRING];
    [UserDefaults synchronize];
    return finalStr;
}

- (void)loadWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    if ([self isFirstLaunch]) {
        BAStartGuideViewController *mainVC = [[BAStartGuideViewController alloc] init];
        self.window.rootViewController = mainVC;
    } else {
        NSLog(@"%d", [UserDefaults boolForKey:ISLOGIN]);
        if ([UserDefaults boolForKey:ISLOGIN] == 0) {
            self.window.rootViewController = [[BALoginController alloc] init];
        } else {
            BATabBarControllerConfig *tabBarControllerConfig = [[BATabBarControllerConfig alloc] init];
            tabBarControllerConfig.tabBarController.delegate = self;
            self.window.rootViewController = tabBarControllerConfig.tabBarController;
        }
    }
    [self.window makeKeyAndVisible];
}

- (BOOL)isFirstLaunch {
    NSString *key = @"appVersion";
    NSString *version = [Device getAPPVersion];
    NSString *saveVersion = [UserDefaults objectForKey:key];
    [UserDefaults setObject:version forKey:key];
    [UserDefaults synchronize];
    if([version isEqualToString:saveVersion]) {
        return NO;
    } else {
        return YES;
    }
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    if ([[self getCurrentVCFrom:viewController] isKindOfClass:[BAMeController class]]) {
        if ([UserDefaults boolForKey:ISLOGIN]) {
            return YES;
        } else {
            BANavigationController *vc = [[BANavigationController alloc] initWithRootViewController:[[BALoginController alloc] init]];
            [[self cyl_tabBarController] presentViewController:vc animated:NO completion:^{

            }];
            return NO;
        }
    } else {
        return YES;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            if (@available(iOS 10.0, *)) {
                _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"_65"];
            } else {
                // Fallback on earlier versions
            }
            if (@available(iOS 10.0, *)) {
                [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
