//
//  MPComposeService.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposeService.h"
#import "MPNetworkServicesImpl.h"

@interface MPComposeService ()

@property (nonatomic, strong) MPNetworkServicesImpl *service;
@property (nonatomic, weak) UIViewController *controller;

@end

@implementation MPComposeService

- (instancetype)initWithNavController:(UINavigationController *) controller
{
    self = [super init];
    if (self) {
        _controller = controller;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _service = [[MPNetworkServicesImpl alloc] init];
}

- (id<ModelNetwork>)getNetworkService
{
    return self.service;
}

- (void)pushViewModel:(id)viewModel
{

}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
