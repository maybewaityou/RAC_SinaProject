//
//  User.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    _vip = _mbtype > 2;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"User description:%@\n idStr: %@\nscreen_name: %@\nname: %@\nprovince: %@\ncity: %@\nlocation: %@\ndesc: %@\nurl: %@\nprofile_image_url: %@\ndomain: %@\ngender: %@\nfollowers_count: %@\nfriends_count: %@\nstatuses_count: %@\nfavourites_count: %@\ncreated_at: %@\nfollowing: %@\nallow_all_act_msg: %@\nremark: %@\ngeo_enabled: %@\nverified: %@\nallow_all_comment: %@\navatar_large: %@\nverified_reason: %@\nfollow_me: %@\nonline_status: %@\nbi_followers_count: %@\n",[super description], self.idStr, self.screen_name, self.name, self.province, self.city, self.location, self.desc, self.url, self.profile_image_url, self.domain, self.gender, self.followers_count, self.friends_count, self.statuses_count, self.favourites_count, self.created_at, self.following, self.allow_all_act_msg, self.remark, self.geo_enabled, self.verified, self.allow_all_comment, self.avatar_large, self.verified_reason, self.follow_me, self.online_status, self.bi_followers_count];
}


@end
