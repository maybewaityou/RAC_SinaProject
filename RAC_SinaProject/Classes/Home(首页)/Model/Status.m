//
//  Status.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "Status.h"

@implementation Status

- (NSString *)description
{
    return [NSString stringWithFormat:@"Status description:%@\n created_at: %@\nidStr: %@\ntext: %@\nfavorited: %@\ntruncated: %@\nin_reply_to_status_id: %@\nin_reply_to_user_id: %@\nin_reply_to_screen_name: %@\ngeo: %@\nmid: %@\nreposts_count: %@\ncomments_count: %@\nuser: %@\n",[super description], self.created_at, self.idStr, self.text, self.favorited, self.truncated, self.in_reply_to_status_id, self.in_reply_to_user_id, self.in_reply_to_screen_name, self.geo, self.mid, self.reposts_count, self.comments_count, self.user];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealoc",self);
}

@end
