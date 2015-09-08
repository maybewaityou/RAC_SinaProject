//
//  Status.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"
#import "MPPhoto.h"
#import "NSDate+Extension.h"

@implementation Status

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [MPPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *createdDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createdDate toDate:now options:0];
    
    if ([createdDate isThisYear]) {
        if ([createdDate isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdDate];
        }else if([createdDate isToday]){
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdDate];
        }
    }else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Status description:%@\n created_at: %@\nidstr: %@\ntext: %@\nfavorited: %@\ntruncated: %@\nin_reply_to_status_id: %@\nin_reply_to_user_id: %@\nin_reply_to_screen_name: %@\ngeo: %@\nmid: %@\nreposts_count: %zd\ncomments_count: %zd\nattitudes_count: %zd\nsource: %@\nuser: %@\npic_urls: %@\nretweeted_status: %@\n",[super description], self.created_at, self.idstr, self.text, self.favorited, self.truncated, self.in_reply_to_status_id, self.in_reply_to_user_id, self.in_reply_to_screen_name, self.geo, self.mid, self.reposts_count, self.comments_count, self.attitudes_count, self.source, self.user, self.pic_urls, self.retweeted_status];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealoc",self);
}


@end
