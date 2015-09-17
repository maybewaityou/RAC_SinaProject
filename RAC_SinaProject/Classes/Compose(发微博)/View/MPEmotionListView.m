//
//  MPEmotionListView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/13.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionListView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"

#define MPEmotionPageSize (20)

@interface MPEmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIPageControl *pageControl;

@end

@implementation MPEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = NO;
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = [emotions copy];
    
    NSUInteger count = (emotions.count + MPEmotionPageSize - 1) / MPEmotionPageSize;
    
    self.pageControl.numberOfPages = count;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIView *pageView = [[UIView alloc] init];
//        pageView.backgroundColor = [UIColor MPRandomColor];
        [self.scrollView addSubview:pageView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;

    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.x = self.scrollView.y = 0;
    
    NSUInteger count = self.scrollView.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        pageView.width = self.scrollView.width;
        pageView.height = self.scrollView.height;
        pageView.x = i * pageView.width;
        pageView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, self.scrollView.height);
}

#pragma mark - UIScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
