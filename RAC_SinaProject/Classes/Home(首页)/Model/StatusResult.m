//
//  StatusResult.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "StatusResult.h"
#import "MJExtension.h"

@implementation StatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"statuses" : @"Status"
             };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"StatusResult description:%@\n statuses: %@\nprevious_cursor: %@\nnext_cursor: %@\ntotal_number: %@\n",[super description], self.statuses, self.previous_cursor, self.next_cursor, self.total_number];
}

@end
