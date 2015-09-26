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
#import "RegexKitLite.h"
#import <UIKit/UIKit.h>
#import "User.h"

@interface Status ()

@end

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
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createdDate];
    }
}

- (void)setSource:(NSString *)source
{
    if (!source || [source isEqualToString:@""]) {
        return;
    }
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    _attributedText = [self attributedTextWithText:text];
}

- (void)setRetweeted_status:(Status *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    User *retweetStatusUser = retweeted_status.user;
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweetStatusUser.name, retweeted_status.text];
    _retweetedAttributedText = [self attributedTextWithText:retweetContent];
}

/**
 * 普通文字转为属性文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionPattern, atPattern, topicPattern, urlPattern];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
    }];
    return attributedText;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Status description:%@\n created_at: %@\nidstr: %@\ntext: %@\nfavorited: %@\ntruncated: %@\nin_reply_to_status_id: %@\nin_reply_to_user_id: %@\nin_reply_to_screen_name: %@\ngeo: %@\nmid: %@\nreposts_count: %@\ncomments_count: %@\nattitudes_count: %@\nsource: %@\nuser: %@\npic_urls: %@\nretweeted_status: %@\n",[super description], self.created_at, self.idstr, self.text, self.favorited, self.truncated, self.in_reply_to_status_id, self.in_reply_to_user_id, self.in_reply_to_screen_name, self.geo, self.mid, self.reposts_count, self.comments_count, self.attitudes_count, self.source, self.user, self.pic_urls, self.retweeted_status];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealoc",self);
}


@end
