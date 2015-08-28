//
//  MPAccountTool.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPAccountTool.h"

#define kMPAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation MPAccountTool

+ (void)saveAccount:(MPAccount *)account
{
    account.created_date = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:kMPAccountPath];
}

+ (MPAccount *)account
{
    MPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kMPAccountPath];
    
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expiresDate = [account.created_date dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    NSComparisonResult result = [expiresDate compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
