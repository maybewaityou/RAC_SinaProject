//
//  AppDelegate.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPAppDelegate.h"
#import "MPHomeViewController.h"
#import "MPDiscoverViewController.h"
#import "MPMessageCenterViewController.h"
#import "MPProfileViewController.h"
#import "UIColor+Extension.h"

@interface MPAppDelegate ()

@end

@implementation MPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *rootController = [[UITabBarController alloc] init];
    self.window.rootViewController = rootController;
    
    MPHomeViewController *homeController = [[MPHomeViewController alloc] init];
    MPMessageCenterViewController *messageController = [[MPMessageCenterViewController alloc] init];
    MPDiscoverViewController *discoverController = [[MPDiscoverViewController alloc] init];
    MPProfileViewController *profileController = [[MPProfileViewController alloc] init];
    
    [self setupController:homeController title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self setupController:messageController title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self setupController:discoverController title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self setupController:profileController title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    [rootController addChildViewController:homeController];
    [rootController addChildViewController:messageController];
    [rootController addChildViewController:discoverController];
    [rootController addChildViewController:profileController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    return YES;
}

- (void)setupController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithR:123 G:123 B:123];
    NSMutableDictionary *selectedTexAttrs = [NSMutableDictionary dictionary];
    selectedTexAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [controller.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:selectedTexAttrs forState:UIControlStateSelected];
    
    controller.view.backgroundColor = [UIColor MPRandomColor];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
