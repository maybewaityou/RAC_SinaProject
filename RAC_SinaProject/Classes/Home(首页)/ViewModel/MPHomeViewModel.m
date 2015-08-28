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
#import "Constant.h"
#import "StatusResult.h"
#import "MJExtension.h"

@interface MPHomeViewModel ()

@property (nonatomic, strong)MPHomeService *service;
@property (nonatomic, strong)MPAccount *account;

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
    self.title = @"首页";
    self.selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"===>>> %@",input);
        return [RACSignal empty];
    }];
}

- (void)requestUserInfo
{
    [[[self.service getNetworkService] signalWithType:@"get" url:USER_INFO_URL
                                           parameter:@{
                                                       @"access_token" : self.account.access_token,
                                                       @"uid" : self.account.uid
                                                      }]
     subscribeNext:^(id response) {
         NSLog(@"== xxx =>>> %@",response);
         self.title = response[@"name"];
    }];
}

- (void)loadNewStatus
{
    [[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                           parameter:@{
                                                       @"access_token" : self.account.access_token
                                                       }]
    subscribeNext:^(id response) {
        self.statuses = [StatusResult objectWithKeyValues:response];
    }];
}

- (MPAccount *)account
{
    if (_account == nil) {
        _account = [MPAccountTool account];
    }
    return _account;
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
