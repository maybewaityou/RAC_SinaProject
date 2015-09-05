//
//  MPHomeService.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeService.h"
#import "MPNetworkServicesImpl.h"

@interface MPHomeService ()

@property (nonatomic, strong)MPNetworkServicesImpl *service;
@property (nonatomic, strong)UIViewController *controller;

@end

@implementation MPHomeService

- (instancetype)initWithNavController:(UINavigationController *) controller
{
    if (self = [super init]) {
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
