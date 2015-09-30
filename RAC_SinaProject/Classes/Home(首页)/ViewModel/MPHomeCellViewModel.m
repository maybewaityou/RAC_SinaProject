//
//  MPHomeCellViewModel.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/30.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeCellViewModel.h"
#import "MPHomeCellService.h"

@interface MPHomeCellViewModel ()

@property (nonatomic, strong) MPHomeCellService *service;

@end

@implementation MPHomeCellViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _service = [[MPHomeCellService alloc] init];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
