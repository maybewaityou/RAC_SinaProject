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

@interface MPEmotionPageView ()

@property (nonatomic, strong)MPEmotionPopView *popView;

@end

@implementation MPEmotionPageView

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
             self.popView.emotion = button.emotion;
             
             UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
             [window addSubview:self.popView];
             
             CGRect btnFrame = [button convertRect:button.bounds toView:nil];
             self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height; // 100
             self.popView.centerX = CGRectGetMidX(btnFrame);
             
             [Async mainAfter:0.25 block:^{
                 @strongify(self);
                 [self.popView removeFromSuperview];
             }];
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
        MPEmotionButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % MPEmotionMaxCols) * btnW;
        btn.y = inset + (i / MPEmotionMaxCols) * btnH;
    }

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


@end
