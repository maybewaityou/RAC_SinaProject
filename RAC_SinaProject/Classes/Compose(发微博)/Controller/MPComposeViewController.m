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
#import "MPComposePhotoViews.h"

#define margin10 (10)

@interface MPComposeViewController () <UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)MPComposeViewModel *viewModel;

@property (nonatomic, weak)UILabel *titleView;
@property (nonatomic, weak)SZTextView *textView;
@property (nonatomic, weak)MPComposeToolbar *toolbar;
@property (nonatomic, weak)MPComposePhotoViews *photoViews;

@end

@implementation MPComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDatas];
    [self setupTitle];
    [self setupViews];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
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
 
    [self setupTextView];
    [self setupPhotoViews];
    [self setupToolbar];
}

- (void)setupTextView
{
    SZTextView *textView = [SZTextView new];
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:15.0];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderTextColor = [UIColor lightGrayColor];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    UIEdgeInsets margins = UIEdgeInsetsMake(margin10, margin10, margin10, margin10);
    @weakify(self);
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view).insets(margins);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification *notification) {
        
        NSDictionary *userInfo = notification.userInfo;
        double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [UIView animateWithDuration:duration animations:^{
            @strongify(self);
            if (keyboardFrame.origin.y > self.view.height) {
                self.toolbar.y = self.view.height - self.toolbar.height;
            }else{
                self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
            }
        }];
    }];
}

- (void)setupPhotoViews
{
    MPComposePhotoViews *photoViews = [[MPComposePhotoViews alloc] init];
    photoViews.backgroundColor = [UIColor blueColor];
    [self.textView addSubview:photoViews];
    self.photoViews = photoViews;
    @weakify(self);
    [photoViews mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.textView).offset(100);
        make.left.right.equalTo(self.textView);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.textView);
    }];
}

- (void)setupToolbar
{
    MPComposeToolbar *toolbar = [[MPComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
//    self.textView.inputAccessoryView = toolbar;
    self.toolbar = toolbar;
//    @weakify(self);
//    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.centerY.equalTo(self.textView);
//        make.bottom.equalTo(self.textView);
//        make.width.equalTo(self.view);
//        make.height.equalTo(@44);
//    }];
    @weakify(self);
    [RACObserve(toolbar, buttonSignal) subscribeNext:^(RACSignal *buttonSignal) {
        [buttonSignal subscribeNext:^(id value) {
            @strongify(self);
            NSInteger type = [value integerValue];
            switch (type) {
                case MPComposeToolbarButtonCamera:
                    [self openCamera];
                    break;
                case MPComposeToolbarButtonPicture:
                    [self openAblum];
                    break;
                case MPComposeToolbarButtonMention:
                    NSLog(@"===>>> Mention");
                    break;
                case MPComposeToolbarButtonTrend:
                    NSLog(@"===>>> Trend");
                    break;
                case MPComposeToolbarButtonEmoticon:
                    NSLog(@"===>>> Emoticon");
                    break;
                    
                default:
                    break;
            }
        }];
    }];
}

#pragma mark - Toolbar方法
- (void)openCamera
{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAblum
{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - 左键
- (void)onLeftClick:(UIBarButtonItem *)leftBar
{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 右键
- (void)onRightClick:(UIBarButtonItem *)rightBar
{
    [self.viewModel sendStatus];
}

#pragma mark - UITextView代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

#pragma mark - ImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoViews addImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
