//
//  AppDelegate.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPAppDelegate.h"
#import "MPTabBarViewController.h"
#import "MPNewfeatureViewController.h"
#import "MPOAuthViewController.h"
#import "TestViewController01.h"
#import "TestViewController00.h"
#import "MPAccount.h"

@interface MPAppDelegate ()

@end

@implementation MPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    MPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (account) {
    //    MPTabBarViewController *rootController = [[MPTabBarViewController alloc] init];
    //    self.window.rootViewController = rootController;
        
        MPNewfeatureViewController *controller = [[MPNewfeatureViewController alloc] init];
        self.window.rootViewController = controller;
    } else {
        MPOAuthViewController *controller = [[MPOAuthViewController alloc] init];
        self.window.rootViewController = controller;
    }

//    TestViewController01 *controller = [[TestViewController01 alloc] init];
//    TestViewController00 *root = [[TestViewController00 alloc] initWithRootViewController:controller];
//    self.window.rootViewController = root;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    return YES;
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
