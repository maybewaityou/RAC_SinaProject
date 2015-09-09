//
//  ViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MPHomeViewModel.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "MPTableViewBindingHelper.h"
#import "MPHomeStatusCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "Status.h"
#import "UIView+Extension.h"
#import "MPHomeStatusNoticeView.h"

@interface MPHomeViewController ()

@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong)MPHomeViewModel *viewModel;

@end

@implementation MPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDatas];
    [self setupTitle];
    [self setupViews];
    [self bindViewModel];
}

- (void)bindViewModel
{
    RAC(self.navigationItem, title) = RACObserve(self.viewModel, title);
    
    @weakify(self);
    [RACObserve(self.viewModel, isLoadNewFinished) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [[[MPHomeStatusNoticeView alloc] initWithCount:self.viewModel.newStatusCount aboveView:self.navigationController.view belowView:self.navigationController.navigationBar] show];
            self.viewModel.newStatusCount = 0;
            self.viewModel.isLoadNewFinished = NO;
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }];
    
    [RACObserve(self.viewModel, isLoadNewError) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.viewModel.isLoadNewError = NO;
            [self.tableView.header endRefreshing];
        }
    }];
    
    [RACObserve(self.viewModel, isLoadMoreFinished) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.viewModel.isLoadMoreFinished = NO;
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }
    }];
    
    [RACObserve(self.viewModel, isLoadMoreError) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.viewModel.isLoadMoreError = NO;
            [self.tableView.footer endRefreshing];
        }
    }];
    
    [RACObserve(self.viewModel, isNoMoreStatuses) subscribeNext:^(id x) {
        if ([x boolValue]) {
            self.viewModel.isNoMoreStatuses = NO;
            [self.tableView.footer noticeNoMoreData];
        }
    }];
    
    [RACObserve(self.viewModel, unReadStatusCount) subscribeNext:^(id x) {
        if ([x integerValue] > 0) {
            self.tabBarItem.badgeValue = [x description];
            [UIApplication sharedApplication].applicationIconBadgeNumber = [x integerValue];
        }else{
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }];

    [MPTableViewBindingHelper bindingHelpWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, statuses.statuses) selectionCommand:self.viewModel.selectionCommand templateCellClass:[MPHomeStatusCell class]];
}

- (void)initDatas
{
    MPHomeViewModel *viewModel = [[MPHomeViewModel alloc] initWithNavController:self.navigationController];
    self.viewModel = viewModel;
    
//    [viewModel requestUserInfo];
//    [viewModel loadStatus];
}

- (void)setupTitle
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" onClickListener:^(UIView *view) {
        NSLog(@"===>>> friend search");
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" onClickListener:^(UIView *view) {
        NSLog(@"===>>> scan QRCode");
    }];
}

- (void)setupViews
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.fd_debugLogEnabled = YES;
    tableView.fd_debugLogEnabled = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.viewModel loadNewStatus];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.viewModel loadMoreStatus];
    }];
    
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
