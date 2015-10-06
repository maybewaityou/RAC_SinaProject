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
#import "MaterialProgress.h"
#import "MPStatusTool.h"

@interface MPHomeViewModel ()

@property (nonatomic, strong) MPHomeService *service;
@property (nonatomic, strong) MPAccount *account;

@property (nonatomic, copy) NSMutableArray *tempStatus;

@end

@implementation MPHomeViewModel

#pragma mark - 初始化
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

#pragma mark - 获取用户数据
- (void)requestUserInfo
{
    [[MaterialProgress sharedMaterialProgress] show];
    @weakify(self);
    [[[self.service getNetworkService] signalWithType:@"get" url:USER_INFO_URL
                                            parameter:@{
                                                       @"access_token" : self.account.access_token,
                                                       @"uid" : self.account.uid
                                                      }]
     subscribeNext:^(id response) {
         [[MaterialProgress sharedMaterialProgress] dismiss];
         @strongify(self);
         self.title = response[@"name"];
         self.account.name = response[@"name"];
         [MPAccountTool saveAccount:self.account];
    }];
}

#pragma mark - 获取微博数据
- (void)loadStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.account.access_token forKey:@"access_token"];
    
    if (![self loadStatusFromInternetOrDB:params]) {
        [self loadStatusFromInternet:params];
    }else{
        [self loadStatusFromDB:params];
    }
    
    //轮询获取未读微博数
    [self fetchUnReadStatusCount];
}

- (void)loadNewStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    Status *status = self.statuses.statuses.firstObject;
    if (status.idstr){
        [params setValue:status.idstr forKey:@"since_id"];
    }
    [params setValue:self.account.access_token forKey:@"access_token"];
    
    if (![self loadStatusFromInternetOrDB:params]) {
        [self loadNewStatusFromInternet:params];
    }else{
        [self loadStatusFromDB:params];
    }
}

- (void)loadMoreStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    Status *status = self.statuses.statuses.lastObject;
    if (!status.idstr){
        self.isLoadMoreFinished = YES;
        return;
    }
    long long max_id = status.idstr.longLongValue - 1;
    [params setValue:[NSString stringWithFormat:@"%lld",max_id] forKey:@"max_id"];
    [params setValue:self.account.access_token forKey:@"access_token"];
    
    if (![self loadStatusFromInternetOrDB:params]) {
        [self loadMoreStatusFromInternet:params];
    }else{
        [self loadStatusFromDB:params];
    }
}

- (void)fetchUnReadStatusCount
{
    @weakify(self);
    [[RACSignal interval:UN_READ_STATUS_TIMEINTERVAL onScheduler:[RACScheduler scheduler]] subscribeNext:^(id x) {
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


#pragma mark - 判断从网络获取还是从数据库中获取数据
- (NSUInteger)loadStatusFromInternetOrDB:(NSDictionary *)params
{
    NSArray *statusesArray = [MPStatusTool statusWithParams:params];
    return statusesArray.count;
}

#pragma mark - 从网络获取数据
- (void)loadStatusFromInternet:(NSDictionary *)params
{
    [[MaterialProgress sharedMaterialProgress] show];
    @weakify(self);
    [[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                            parameter:params]
     subscribeNext:^(id response) {
         [[MaterialProgress sharedMaterialProgress] dismiss];
         @strongify(self);
         self.statuses = [StatusResult objectWithKeyValues:response];
         [self.tempStatus addObjectsFromArray:self.statuses.statuses];
         // 存入数据库
         [MPStatusTool saveStatuses:response[@"statuses"]];
     }];
}

- (void)loadNewStatusFromInternet:(NSDictionary *)params
{
    [[MaterialProgress sharedMaterialProgress] show];
    
    @weakify(self);
    [[[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                             parameter:params]
      doNext:^(id response) {
          [[MaterialProgress sharedMaterialProgress] dismiss];
          @strongify(self);
          StatusResult *newStatuses = [StatusResult objectWithKeyValues:response];
          NSRange range = NSMakeRange(0, newStatuses.statuses.count);
          NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
          [self.tempStatus insertObjects:newStatuses.statuses atIndexes:indexSet];
          self.statuses.statuses = [self.tempStatus copy];
          self.newStatusCount = newStatuses.statuses.count;
          self.isLoadNewFinished = YES;
          self.isLoadNewError = NO;
          
          // 存入数据库
          [MPStatusTool saveStatuses:response[@"statuses"]];
      }] subscribeError:^(NSError *error) {
          [[MaterialProgress sharedMaterialProgress] dismiss];
          @strongify(self);
          self.isLoadNewError = YES;
      }];
}

- (void)loadMoreStatusFromInternet:(NSDictionary *)params
{
    [[MaterialProgress sharedMaterialProgress] show];
    @weakify(self);
    [[[[self.service getNetworkService] signalWithType:@"get" url:NEW_STATUS_URL
                                             parameter:params]
      doNext:^(id response) {
          [[MaterialProgress sharedMaterialProgress] dismiss];
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
          // 存入数据库
          [MPStatusTool saveStatuses:response[@"statuses"]];
      }] subscribeError:^(NSError *error) {
          [[MaterialProgress sharedMaterialProgress] dismiss];
          @strongify(self);
          self.isLoadMoreError = YES;
      }];
}

#pragma mark - 从数据库中获取数据
- (void)loadStatusFromDB:(NSDictionary *)params
{
    NSArray *statusesArray = [MPStatusTool statusWithParams:params];
    NSArray *statuses = [Status objectArrayWithKeyValuesArray:statusesArray];
    [self.tempStatus addObjectsFromArray:statuses];
    self.statuses.statuses = [self.tempStatus copy];
    
    self.isLoadMoreFinished = YES;
    self.isLoadMoreError = NO;
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

- (StatusResult *)statuses
{
    if (!_statuses) {
        _statuses = [[StatusResult alloc] init];
    }
    return _statuses;
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
