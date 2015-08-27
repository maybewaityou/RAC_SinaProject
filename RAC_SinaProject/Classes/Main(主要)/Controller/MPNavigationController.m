//
//  MPNavigationController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNavigationController.h"
#import "ReactiveCocoa.h"
#import "UIView+Extension.h"

@interface MPNavigationController ()

@end

@implementation MPNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count <= 0) {
        return;
    }
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    [moreButton setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    
    backButton.size = backButton.currentBackgroundImage.size;
    moreButton.size = moreButton.currentBackgroundImage.size;
    
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self popViewControllerAnimated:YES];
    }];
    
    [[moreButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self popToRootViewControllerAnimated:YES];
    }];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    
    [super pushViewController:viewController animated:animated];
}

@end
