//
//  MPNewfeatureViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNewfeatureViewController.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "MPTabBarViewController.h"

#define MPNewfeatureCount 4

@interface MPNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak)UIPageControl *pageControl;
@property (nonatomic, weak)UIScrollView *scrollView;

@end

@implementation MPNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(screenW * MPNewfeatureCount, screenH);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    @weakify(self);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view).insets(padding);
    }];
    
    UIImageView *imageView00 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_feature_1"]];
    [scrollView addSubview:imageView00];
    [imageView00 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.equalTo(self.view);
    }];
    UIImageView *imageView01 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_feature_2"]];
    [scrollView addSubview:imageView01];
    [imageView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(imageView00.mas_right);
        make.width.equalTo(@(screenW));
    }];
    UIImageView *imageView02 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_feature_3"]];
    [scrollView addSubview:imageView02];
    [imageView02 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(imageView01.mas_right);
        make.width.equalTo(@(screenW));
    }];
    UIImageView *imageView03 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_feature_4"]];
    [scrollView addSubview:imageView03];
    [imageView03 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(imageView02.mas_right);
        make.width.equalTo(@(screenW));
    }];
    
    [self addShareButton:imageView03];

    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithR:253 G:98 B:42];
    pageControl.pageIndicatorTintColor = [UIColor colorWithR:189 G:189 B:189];
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.numberOfPages = MPNewfeatureCount;
    pageControl.centerX = screenW * 0.5;
    pageControl.centerY = screenH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

- (void)addShareButton:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:shareButton];
    @weakify(self);
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(imageView).offset(self.view.height*2/3);
        make.centerX.equalTo(imageView);
        make.width.equalTo(@(200));
        make.height.equalTo(@(30));
    }];
    [[shareButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         shareButton.selected = !shareButton.selected;
    }];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    startButton.size = startButton.currentBackgroundImage.size;
    [imageView addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareButton.mas_bottom).offset(20);
        make.centerX.equalTo(shareButton);
    }];
    [[startButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         UIWindow *window = [UIApplication sharedApplication].keyWindow;
         window.rootViewController = [[MPTabBarViewController alloc] init];
    }];
}

#pragma mark - ScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)dealloc
{
    NSLog(@"===>>> MPNewfeatureViewController dealloc");
}



@end
