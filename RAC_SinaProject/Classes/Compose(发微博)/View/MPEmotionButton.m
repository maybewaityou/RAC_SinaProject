//
//  MPEmotionButton.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionButton.h"
#import "MPEmotion.h"
#import "NSString+Emoji.h"

@implementation MPEmotionButton

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
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

-(void)setEmotion:(MPEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else{
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
