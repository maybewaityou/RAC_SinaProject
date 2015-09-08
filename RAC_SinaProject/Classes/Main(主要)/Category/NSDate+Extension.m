//
//  NSDate+Extension.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateString];
    now = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:now];
    
    return [nowString isEqualToString:dateString];
}

@end
