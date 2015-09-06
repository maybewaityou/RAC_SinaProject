//
//  MPPermissionUtils.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/6.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPPermissionUtils.h"

@interface MPPermissionUtils ()

@end

@implementation MPPermissionUtils

+ (void)requestUserNotificationPermission {
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>= 8.0 ) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
}

@end
