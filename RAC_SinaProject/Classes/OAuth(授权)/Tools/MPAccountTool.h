//
//  MPAccountTool.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPAccount.h"

@interface MPAccountTool : NSObject

+ (void)saveAccount:(MPAccount *)account;

+ (MPAccount *)account;

@end
