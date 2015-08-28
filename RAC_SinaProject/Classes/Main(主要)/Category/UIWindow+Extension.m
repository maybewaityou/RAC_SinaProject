//
//  UIWindow+Extension.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MPNewfeatureViewController.h"
#import "MPTabBarViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootController
{
    MPTabBarViewController *controller = [[MPTabBarViewController alloc] init];
//    MPNewfeatureViewController *controller = [[MPNewfeatureViewController alloc] init];
    self.rootViewController = controller;
}

@end
