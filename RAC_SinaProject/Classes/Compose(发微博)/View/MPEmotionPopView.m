//
//  MPEmotionPopView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionPopView.h"
#import "MPEmotionButton.h"
#import "Masonry.h"
#import "RACEXTScope.h"
#import "UIView+Extension.h"

@interface MPEmotionPopView ()


@property (nonatomic, weak)UIImageView *backgroundImageView;
@property (nonatomic, weak)MPEmotionButton *emotionButton;
@end

@implementation MPEmotionPopView

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
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    @weakify(self);
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.right.bottom.equalTo(self);
    }];
    
    MPEmotionButton *emotionButton = [[MPEmotionButton alloc] init];
    [self addSubview:emotionButton];
    self.emotionButton = emotionButton;
    [emotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.right.equalTo(self);
        make.height.equalTo(@64);
    }];
}

- (void)setEmotion:(MPEmotion *)emotion
{
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
}

@end
