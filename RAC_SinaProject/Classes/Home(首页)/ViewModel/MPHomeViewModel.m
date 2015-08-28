//
//  MPHomeViewModel.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeViewModel.h"
#import "MPHomeService.h"
#import "ModelNetwork.h"
#import "MPAccount.h"
#import "MPAccountTool.h"

@interface MPHomeViewModel ()

@property (nonatomic, strong)MPHomeService *service;

@end

@implementation MPHomeViewModel

- (instancetype)initWithNavController:(UINavigationController *)controller
{
    if (self = [super init]) {
        _service = [[MPHomeService alloc] initWithNavController:controller];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    
}

- (void)requestUserInfo
{
    MPAccount *account = [MPAccountTool account];
    [[[self.service getNetworkService] signalWithType:@"get" url:@"https://api.weibo.com/2/users/show.json"
                                           parameter:@{
                                                        @"access_token":account.access_token,
                                                        @"uid":account.uid
                                                      }]
     subscribeNext:^(id x) {
         NSLog(@"== xxx =>>> %@",x);
    }];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
