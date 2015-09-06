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
#import "Status.h"

@interface MPHomeViewModel ()

@property (nonatomic, strong)MPHomeService *service;
@property (nonatomic, strong)MPAccount *account;

@property (nonatomic, copy)NSMutableArray *tempStatus;

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
    @weakify(self);
    [[[self.service getNetworkService] signalWithType:@"get" url:USER_INFO_URL
                                           parameter:@{
                                                       @"access_token" : self.account.access_token,
                                                       @"uid" : self.account.uid
                                                      }]
     subscribeNext:^(id response) {
         @strongify(self);
         self.title = response[@"name"];
    }];
}

- (void)loadStatus
{
    @weakify(self);
    [[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                            parameter:@{
                                                        @"access_token" : self.account.access_token
                                                        }]
     subscribeNext:^(id response) {
         @strongify(self);
         self.statuses = [StatusResult objectWithKeyValues:response];
         [self.tempStatus addObjectsFromArray:self.statuses.statuses];
     }];
    
    [self fetchUnReadStatusCount];
}

- (void)loadNewStatus
{
    Status *status = self.statuses.statuses.firstObject;
    if (!status.idstr){
        self.isLoadNewFinished = YES;
        return;
    }
    @weakify(self);
    [[[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                            parameter:@{
                                                        @"access_token" : self.account.access_token,
                                                        @"since_id" : status.idstr
                                                        }]
     doNext:^(id response) {
         @strongify(self);
         StatusResult *newStatuses = [StatusResult objectWithKeyValues:response];
         NSRange range = NSMakeRange(0, newStatuses.statuses.count);
         NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
         [self.tempStatus insertObjects:newStatuses.statuses atIndexes:indexSet];
         self.statuses.statuses = [self.tempStatus copy];
         self.newStatusCount = newStatuses.statuses.count;
         self.isLoadNewFinished = YES;
         self.isLoadNewError = NO;
     }] subscribeError:^(NSError *error) {
         @strongify(self);
         self.isLoadNewError = YES;
     }];
}

- (void)loadMoreStatus
{
    Status *status = self.statuses.statuses.lastObject;
    if (!status.idstr){
        self.isLoadMoreFinished = YES;
        return;
    }
    long long max_id = status.idstr.longLongValue - 1;
    @weakify(self);
    [[[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                            parameter:@{
                                                        @"access_token" : self.account.access_token,
                                                        @"max_id" : @(max_id)
                                                        }]
     doNext:^(id response) {
         @strongify(self);
         StatusResult *newStatuses = [StatusResult objectWithKeyValues:response];
         if ([newStatuses.statuses count] == 0) {
             self.isNoMoreStatuses = YES;
             return;
         }
         [self.tempStatus addObjectsFromArray:newStatuses.statuses];
         self.statuses.statuses = [self.tempStatus copy];
         self.isLoadMoreFinished = YES;
         self.isLoadMoreError = NO;
     }] subscribeError:^(NSError *error) {
         @strongify(self);
         self.isLoadMoreError = YES;
     }];
}

- (void)fetchUnReadStatusCount
{
    @weakify(self);
    [[RACSignal interval:UN_READ_STATUS_TIMEINTERVAL onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [[[[self.service getNetworkService] signalWithType:@"get" url:UN_READ_STATUS_URL
                                                    parameter:@{
                                                                @"access_token" : self.account.access_token,
                                                                @"uid" : self.account.uid
                                                                }]
        doNext:^(id response) {
            @strongify(self);
            self.unReadStatusCount = [response[@"status"] integerValue];
        }] subscribeError:^(NSError *error) {
            
        }];
    }];
}

#pragma mark - 懒加载
- (MPAccount *)account
{
    if (_account == nil) {
        _account = [MPAccountTool account];
    }
    return _account;
}

- (NSMutableArray *)tempStatus
{
    if (!_tempStatus) {
        _tempStatus = [NSMutableArray array];
    }
    return _tempStatus;
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
