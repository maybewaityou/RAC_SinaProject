//
//  MPTabBar.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@class MPTabBar;

@interface MPTabBar : UITabBar

@property (nonatomic, strong) RACSignal *onPlusClickSignal;

@end
