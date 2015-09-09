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
#import "Masonry.h"
#import "UIView+Toast.h"
#import "SZTextView.h"
#import "MPComposeToolbar.h"

#define margin10 (10)

@interface MPComposeViewController ()

@property (nonatomic, strong)MPComposeViewModel *viewModel;

@property (nonatomic, weak)UILabel *titleView;
@property (nonatomic, weak)SZTextView *textView;

@end

@implementation MPComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDatas];
    [self setupTitle];
    [self setupViews];
    [self setupToolbar];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 判断发送键是否可点击
    @weakify(self);
    [[self.textView.rac_textSignal map:^id(NSString *string) {
        return string.length > 0 ? @(YES) : @(NO);
    }] subscribeNext:^(NSNumber *boolean) {
        @strongify(self);
        self.navigationItem.rightBarButtonItem.enabled = [boolean boolValue];
    }];
}

- (void)bindViewModel
{
    @weakify(self);
    RAC(self.titleView,text) = RACObserve(self.viewModel, name);
    RAC(self.titleView,attributedText) = RACObserve(self.viewModel, attrStr);
    RAC(self.viewModel,textToSend) = self.textView.rac_textSignal;
    
    [RACObserve(self.viewModel, isSendSuccess) subscribeNext:^(id x) {
        if ([x boolValue]) {
            @strongify(self);
            [self.view makeToast:@"发送成功！" duration:3 position:CSToastPositionCenter];
            self.textView.text = @"";
        }
    }];
}

- (void)initDatas
{
    self.viewModel = [[MPComposeViewModel alloc] initWithNavController:self.navigationController];
    
}

- (void)setupTitle
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(onLeftClick:)];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(onRightClick:)];
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 100;
    titleView.textAlignment = NSTextAlignmentCenter;
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
 
    SZTextView *textView = [SZTextView new];
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:15.0];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderTextColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    UIEdgeInsets margins = UIEdgeInsetsMake(margin10, margin10, -margin10, -margin10);
    @weakify(self);
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view).insets(margins);
    }];
    [textView becomeFirstResponder];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(id x) {

    }];
}

- (void)setupToolbar
{
    MPComposeToolbar *toolbar = [[MPComposeToolbar alloc] init];
//    toolbar.width = self.view.width;
//    toolbar.height = 44;
    [self.view addSubview:toolbar];
//    self.textView.inputAccessoryView = toolbar;
    @weakify(self);
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.textView);
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
}

- (void)onLeftClick:(UIBarButtonItem *)leftBar
{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRightClick:(UIBarButtonItem *)rightBar
{
    [self.viewModel sendStatus];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
