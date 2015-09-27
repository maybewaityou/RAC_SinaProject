//
//  MPEmotionTool.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/24.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionTool.h"
#import "MPEmotion.h"
#import "MJExtension.h"

#define kMPRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]

@implementation MPEmotionTool

static NSMutableArray *_recentEmotions, *_defaultEmotions, *_emojiEmotions, *_lxhEmitons;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kMPRecentEmotionsPath];
    if (!_recentEmotions) {
        _recentEmotions = [NSMutableArray array];
    }
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    if (!_lxhEmitons) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmitons = [MPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
}

+ (void)saveRecentEmotion:(MPEmotion *)emotion
{
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:kMPRecentEmotionsPath];
}

+ (MPEmotion *)emotionWithChs:(NSString *)chs
{
    for (MPEmotion *emotion in _defaultEmotions) {
        if ([chs isEqualToString:emotion.chs]) return emotion;
    }
    for (MPEmotion *emotion in _emojiEmotions) {
        if ([chs isEqualToString:emotion.chs]) return emotion;
    }
    for (MPEmotion *emotion in _lxhEmitons) {
        if ([chs isEqualToString:emotion.chs]) return emotion;
    }
    return nil;
}

+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

+ (NSArray *)defaultEmotions
{
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    return _lxhEmitons;
}

@end
