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

@implementation Status

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [MPPhoto class]};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Status description:%@\n created_at: %@\nidstr: %@\ntext: %@\nfavorited: %@\ntruncated: %@\nin_reply_to_status_id: %@\nin_reply_to_user_id: %@\nin_reply_to_screen_name: %@\ngeo: %@\nmid: %@\nreposts_count: %@\ncomments_count: %@\nsource: %@\nuser: %@\npic_urls: %@\n",[super description], self.created_at, self.idstr, self.text, self.favorited, self.truncated, self.in_reply_to_status_id, self.in_reply_to_user_id, self.in_reply_to_screen_name, self.geo, self.mid, self.reposts_count, self.comments_count, self.source, self.user, self.pic_urls];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealoc",self);
}

@end
