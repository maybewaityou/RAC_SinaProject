//
//  MPMessageCenterViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPMessageCenterViewController.h"
#import "ReactiveCocoa.h"

@interface MPMessageCenterViewController ()

@end

@implementation MPMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTitle];
}

- (void)setupTitle
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"写私信";
    item.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"===>>> 写私信");
        return [RACSignal empty];
    }];
    self.navigationItem.rightBarButtonItem = item;

}

- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}

@end
