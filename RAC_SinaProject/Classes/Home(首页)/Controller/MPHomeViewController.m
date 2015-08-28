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
    
    [MPTableViewBindingHelper bindingHelpWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, statuses.statuses) selectionCommand:self.viewModel.selectionCommand templateCellClass:[MPHomeStatusCell class]];
}

- (void)initDatas
{
    MPHomeViewModel *viewModel = [[MPHomeViewModel alloc] initWithNavController:self.navigationController];
    self.viewModel = viewModel;
    
    [viewModel requestUserInfo];
    [viewModel loadNewStatus];
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
    tableView.fd_debugLogEnabled = YES;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    @weakify(self);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
