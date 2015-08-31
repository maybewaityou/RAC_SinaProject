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
#import "MPNewStatusNoticeView.h"
#import "UIView+Extension.h"

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
    
    [RACObserve(self.viewModel, isLoadFinished) subscribeNext:^(id x) {
        if ([x boolValue]) {
            self.viewModel.isLoadFinished = NO;
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];

            [self showNewStatusCount:self.viewModel.newStatusCount];
        }
    }];
    
    [MPTableViewBindingHelper bindingHelpWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, statuses.statuses) selectionCommand:self.viewModel.selectionCommand templateCellClass:[MPHomeStatusCell class]];
}

- (void)initDatas
{
    MPHomeViewModel *viewModel = [[MPHomeViewModel alloc] initWithNavController:self.navigationController];
    self.viewModel = viewModel;
    
    [viewModel requestUserInfo];
    [viewModel loadStatus];
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
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.fd_debugLogEnabled = YES;
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

- (void)showNewStatusCount:(NSUInteger)count
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
