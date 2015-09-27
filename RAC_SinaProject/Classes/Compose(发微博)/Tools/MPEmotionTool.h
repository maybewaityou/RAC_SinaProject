//
//  MPEmotionTool.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/24.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPEmotion;

@interface MPEmotionTool : NSObject

+ (void)saveRecentEmotion:(MPEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;
+ (MPEmotion *)emotionWithChs:(NSString *)chs;

@end
