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

@interface MPEmotionPageView ()

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

@end
