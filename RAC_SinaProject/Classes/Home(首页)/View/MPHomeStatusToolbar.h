//
//  MPHomeStatusToolbar.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/7.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;

@interface MPHomeStatusToolbar : UIView

@property (nonatomic, strong)Status *status;

+ (instancetype)toolbar;

@end
