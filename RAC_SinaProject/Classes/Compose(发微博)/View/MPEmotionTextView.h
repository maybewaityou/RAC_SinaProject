//
//  MPEmotionTextView.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@class MPEmotion;

@interface MPEmotionTextView : SZTextView

- (void)insertEmotion:(MPEmotion *)emotion;

@end
