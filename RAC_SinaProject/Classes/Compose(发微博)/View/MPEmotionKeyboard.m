//
//  MPEmotionKeyboard.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/13.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionKeyboard.h"
#import "MPEmotionListView.h"
#import "MPEmotionTabBar.h"
#import "UIView+Extension.h"
#import "ReactiveCocoa.h"
#import "MPEmotion.h"
#import "MJExtension.h"
#import "MPEmotionTool.h"
#import "Constant.h"

@interface MPEmotionKeyboard ()

@property (nonatomic, weak)MPEmotionListView *showingListView;
@property (nonatomic, strong)MPEmotionListView *recentListView;
@property (nonatomic, strong)MPEmotionListView *defaultListView;
@property (nonatomic, strong)MPEmotionListView *emojiListView;
@property (nonatomic, strong)MPEmotionListView *lxhListView;

@property (nonatomic, weak)MPEmotionTabBar *tabBar;

@end

@implementation MPEmotionKeyboard

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
    MPEmotionTabBar *tabBar = [[MPEmotionTabBar alloc] init];
    [self addSubview:tabBar];
    self.tabBar = tabBar;
    
    @weakify(self);
    [RACObserve(self.tabBar, selectedSignal) subscribeNext:^(RACSignal *buttonSignal) {
        @strongify(self);
        [buttonSignal subscribeNext:^(id value) {
            @strongify(self);
            
            [self.showingListView removeFromSuperview];
            
            MPEmotionTabBarButtonType type = [value integerValue];
            switch (type) {
                case MPEmotionTabBarButtonTypeRecent:
                    NSLog(@"===>>> 最近");
                    [self addSubview:self.recentListView];
                    break;
                case MPEmotionTabBarButtonTypeDefault:
                    NSLog(@"===>>> 默认");
                    [self addSubview:self.defaultListView];
                    break;
                case MPEmotionTabBarButtonTypeEmoji:
                    NSLog(@"===>>> 表情");
                    [self addSubview:self.emojiListView];
                    break;
                case MPEmotionTabBarButtonTypeLxh:
                    NSLog(@"===>>> 浪小花");
                    [self addSubview:self.lxhListView];
                    break;
                default:
                    break;
            }
            self.showingListView = self.subviews.lastObject;
            [self setNeedsLayout];
        }];
    }];
    
    // 监听选中表情
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:MPEmotionDidSelectNotification object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self);
        self.recentListView.emotions = [MPEmotionTool recentEmotions];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBar.height = 44;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.height - self.tabBar.height;
}

#pragma mark - 懒加载
- (MPEmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[MPEmotionListView alloc] init];
        //TODO 加载沙盒中的表情数据
        _recentListView.emotions = [MPEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (MPEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[MPEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultListView.emotions = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (MPEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView = [[MPEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiListView.emotions = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (MPEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[MPEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotions = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
