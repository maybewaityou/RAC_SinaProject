//
//  MPHomeCellService.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/10/1.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPHomeCellService.h"
#import "MPNetworkServicesImpl.h"

@interface MPHomeCellService ()

@property (nonatomic, strong) MPNetworkServicesImpl *service;

@end

@implementation MPHomeCellService

- (instancetype)init
{
    if (self = [super init]) {
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
