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

+ (void)saveRecentEmotion:(MPEmotion *)emotion
{
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    if (!emotions) {
        emotions = [NSMutableArray array];
    }
    
    [emotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:emotions toFile:kMPRecentEmotionsPath];
}

+ (NSArray *)recentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kMPRecentEmotionsPath];
}

@end
