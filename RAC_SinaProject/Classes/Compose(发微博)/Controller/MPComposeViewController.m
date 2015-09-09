//
//  MPComposeViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposeViewController.h"
#import "MPComposeViewModel.h"
#import "ReactiveCocoa.h"
#import "UIView+Extension.h"
#import "UIView+Toast.h"

@interface MPComposeViewController ()

@property (nonatomic, strong)MPComposeViewModel *viewModel;

@property (nonatomic, weak)UILabel *titleView;

@end

@implementation MPComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDatas];
    [self setupTitle];
    [self setupViews];
    [self bindViewModel];
}

- (void)bindViewModel
{
    RAC(self.titleView,text) = RACObserve(self.viewModel, name);
    RAC(self.titleView,attributedText) = RACObserve(self.viewModel, attrStr);
}

- (void)initDatas
{
    self.viewModel = [[MPComposeViewModel alloc] init];
    
}

- (void)setupTitle
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftClick:)];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(onRightClick:)];
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 100;
    titleView.textAlignment = NSTextAlignmentCenter;
    // 自动换行
    titleView.numberOfLines = 0;
    titleView.y = 50;

    self.navigationItem.leftBarButtonItem = leftBar;
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;


}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)onLeftClick:(UIBarButtonItem *)leftBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRightClick:(UIBarButtonItem *)rightBar
{
    [self.view makeToast:@"发送成功！" duration:3 position:CSToastPositionCenter];
}
@end
