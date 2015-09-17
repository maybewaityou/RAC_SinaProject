//
//  MPEmotionTabBar.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/13.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MPEmotionTabBarButtonTypeRecent,
    MPEmotionTabBarButtonTypeDefault,
    MPEmotionTabBarButtonTypeEmoji,
    MPEmotionTabBarButtonTypeLxh,
} MPEmotionTabBarButtonType;

@class RACSignal;

@interface MPEmotionTabBar : UIView

@property (nonatomic, strong)RACSignal *selectedSignal;

@end
