//
//  MPNavigationController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface MPNavigationController ()

@end

@implementation MPNavigationController

+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

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
