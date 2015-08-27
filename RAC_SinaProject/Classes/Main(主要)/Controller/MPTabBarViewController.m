//
//  MPTabBarViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPTabBarViewController.h"
#import "UIColor+Extension.h"
#import "MPHomeViewController.h"
#import "MPDiscoverViewController.h"
#import "MPMessageCenterViewController.h"
#import "MPProfileViewController.h"
#import "MPNavigationController.h"


@interface MPTabBarViewController ()

@end

@implementation MPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    MPHomeViewController *homeController = [[MPHomeViewController alloc] init];
    MPMessageCenterViewController *messageController = [[MPMessageCenterViewController alloc] init];
    MPDiscoverViewController *discoverController = [[MPDiscoverViewController alloc] init];
    MPProfileViewController *profileController = [[MPProfileViewController alloc] init];
    
    [self setupController:homeController title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self setupController:messageController title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self setupController:discoverController title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self setupController:profileController title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

- (void)setupController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    controller.title = title;
    
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
    
    MPNavigationController *navController = [[MPNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navController];
}

@end
