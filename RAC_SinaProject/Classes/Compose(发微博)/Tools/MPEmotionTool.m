//
//  MPEmotionTool.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/24.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionTool.h"
#import "MPEmotion.h"

#define kMPRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]

@implementation MPEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kMPRecentEmotionsPath];
    if (!_recentEmotions) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)saveRecentEmotion:(MPEmotion *)emotion
{
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:kMPRecentEmotionsPath];
}

+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

@end
