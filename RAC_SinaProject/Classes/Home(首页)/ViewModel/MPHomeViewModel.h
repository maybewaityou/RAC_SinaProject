//
//  MPHomeViewModel.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMViewModel.h"

@interface MPHomeViewModel : RVMViewModel

- (instancetype)initWithNavController:(UIViewController *)controller;
- (void)requestUserInfo;

@end
