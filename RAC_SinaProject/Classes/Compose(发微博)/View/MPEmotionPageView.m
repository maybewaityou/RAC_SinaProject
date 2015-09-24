//
//  MPEmotionPageView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/17.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionPageView.h"
#import "MPEmotion.h"
#import "UIView+Extension.h"
#import "MPEmotionButton.h"
#import "MPEmotionPopView.h"
#import "ReactiveCocoa.h"
#import "Async.h"
#import "Constant.h"

@interface MPEmotionPageView ()

@property (nonatomic, strong)MPEmotionPopView *popView;
@property (nonatomic, weak)UIButton *deleteButton;

@end

@implementation MPEmotionPageView

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
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
    [[deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MPEmotionDeleteNotification object:nil];
    }];
    
    // 添加长点击
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (NSUInteger i = 0; i < count; i++) {
        MPEmotion *emotion = emotions[i];
        MPEmotionButton *button = [[MPEmotionButton alloc] init];
        button.emotion = emotion;
        [self addSubview:button];
        
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             @strongify(self);
             [self buttonClick:button];
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / MPEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / MPEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        MPEmotionButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % MPEmotionMaxCols) * btnW;
        btn.y = inset + (i / MPEmotionMaxCols) * btnH;
    }

    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
}

#pragma mark - 长点击事件
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    MPEmotionButton *button = [self buttonFromLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (button) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:MPEmotionDidSelectNotification
                 object:nil
                 userInfo:@{
                            MPSelectEmotionKey:button.emotion
                            }];
            }
            break;
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.popView showFromButton:button];
            break;
        default:
            break;
    }
}

- (void)buttonClick:(MPEmotionButton *)button
{
    [self.popView showFromButton:button];
    
    @weakify(self);
    [Async mainAfter:0.25 block:^{
        @strongify(self);
        [self.popView removeFromSuperview];
    }];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:MPEmotionDidSelectNotification
     object:nil
     userInfo:@{
                MPSelectEmotionKey:button.emotion
                }];
}

/**
 * 长点击事件，查找相应的button
 */
- (MPEmotionButton *)buttonFromLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        MPEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 懒加载
- (MPEmotionPopView *)popView
{
    if (!_popView) {
        _popView = [[MPEmotionPopView alloc] init];
        _popView.width = 64;
        _popView.height = 91;
    }
    return _popView;
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
