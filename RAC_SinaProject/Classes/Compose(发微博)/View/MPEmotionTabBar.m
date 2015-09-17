//
//  MPEmotionTabBar.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/13.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionTabBar.h"
#import "MPEmotionTabBarButton.h"
#import "UIView+Extension.h"
#import "ReactiveCocoa.h"

@interface MPEmotionTabBar ()

@property (nonatomic, weak)MPEmotionTabBarButton *selectedButton;

@end

@implementation MPEmotionTabBar

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
    [self setupButtonWithTitle:NSLocalizedString(@"recent",nil) type:MPEmotionTabBarButtonTypeRecent];
    [self setupButtonWithTitle:@"默认" type:MPEmotionTabBarButtonTypeDefault];
    [self setupButtonWithTitle:@"Emoji" type:MPEmotionTabBarButtonTypeEmoji];
    [self setupButtonWithTitle:@"浪小花" type:MPEmotionTabBarButtonTypeLxh];
}

- (void)setupButtonWithTitle:(NSString *)title type:(MPEmotionTabBarButtonType)type
{
    MPEmotionTabBarButton *button = [[MPEmotionTabBarButton alloc] init];
    button.tag = type;
    [button setTitle:title forState:UIControlStateNormal];
    [self addSubview:button];
    
    if (button.tag == MPEmotionTabBarButtonTypeDefault) {
        [self setButtonClicked:button];
    }
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self setButtonClicked:button];
    }];
}

- (void)setButtonClicked:(MPEmotionTabBarButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    self.selectedSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(button.tag)];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat width = self.width / count;
    CGFloat height = self.height;
    for (NSUInteger i=0; i<count; i++) {
        MPEmotionTabBarButton *button = self.subviews[i];
        button.y = 0;
        button.width = width;
        button.x = i * width;
        button.height = height;
    }
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
