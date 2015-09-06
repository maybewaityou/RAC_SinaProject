//
//  MPHomeViewModel.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMViewModel.h"
#import "ReactiveCocoa.h"
#import "StatusResult.h"

@interface MPHomeViewModel : RVMViewModel

@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)StatusResult *statuses;
@property (nonatomic, assign)BOOL isLoadNewFinished;
@property (nonatomic, assign)BOOL isLoadNewError;
@property (nonatomic, assign)BOOL isLoadMoreFinished;
@property (nonatomic, assign)BOOL isLoadMoreError;
@property (nonatomic, assign)BOOL isNoMoreStatuses;
@property (nonatomic, assign)NSUInteger newStatusCount;
@property (nonatomic, assign)NSInteger unReadStatusCount;
@property (nonatomic, strong)RACCommand *selectionCommand;

- (instancetype)initWithNavController:(UIViewController *)controller;
- (void)requestUserInfo;
- (void)loadStatus;
- (void)loadNewStatus;
- (void)loadMoreStatus;

@end
