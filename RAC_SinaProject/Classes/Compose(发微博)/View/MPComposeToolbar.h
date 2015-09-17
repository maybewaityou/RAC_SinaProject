//
//  MPComposeToolbar.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/10.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

typedef enum : NSUInteger {
    MPComposeToolbarButtonCamera,
    MPComposeToolbarButtonPicture,
    MPComposeToolbarButtonMention,
    MPComposeToolbarButtonTrend,
    MPComposeToolbarButtonEmoticon
} MPComposeToolbarButtonType;

@interface MPComposeToolbar : UIView

@property (nonatomic, assign)BOOL showKeyboardButton;
@property (nonatomic, strong)RACSignal *buttonSignal;

@end
