//
//  MPHomeService.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelServices.h"

@interface MPHomeService : NSObject <ModelServices>

- (instancetype)initWithNavController:(UINavigationController *) controller;

@end
