//
//  MPNavigationController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface MPNavigationController ()

@end

@implementation MPNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" onClickListener:^(UIView *view) {
            [self popViewControllerAnimated:YES];
        }];
        UIBarButtonItem *moreItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" onClickListener:^(UIView *view) {
            [self popToRootViewControllerAnimated:YES];
        }];
        
        viewController.navigationItem.leftBarButtonItem = backItem;
        viewController.navigationItem.rightBarButtonItem = moreItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
