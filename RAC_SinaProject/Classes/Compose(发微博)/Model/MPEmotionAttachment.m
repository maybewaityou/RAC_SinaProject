//
//  MPEmotionAttachment.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/19.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionAttachment.h"
#import "MPEmotion.h"

@implementation MPEmotionAttachment

- (void)setEmotion:(MPEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
