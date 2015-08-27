//
//  ViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeViewController.h"
#import "TestViewController01.h"
#import "UIBarButtonItem+Extension.h"


@interface MPHomeViewController ()

@end

@implementation MPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTitle];
}

- (void)setupTitle
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" onClickListener:^(UIView *view) {
        NSLog(@"===>>> friend search");
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" onClickListener:^(UIView *view) {
        NSLog(@"===>>> scan QRCode");
    }];
}

@end
