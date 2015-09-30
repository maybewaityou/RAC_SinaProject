//
//  User.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MPUserVerifiedTypeNone = -1, // 没有任何认证
    
    MPUserVerifiedPersonal = 0,  // 个人认证
    
    MPUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    MPUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    MPUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    MPUserVerifiedDaren = 220 // 微博达人
} MPUserVerifiedType;

@interface User : NSObject

//    "id": 1404376560,
@property (nonatomic, copy) NSString *idStr;
//    "screen_name": "zaku",
@property (nonatomic, copy) NSString *screen_name;
//    "name": "zaku",
@property (nonatomic, copy) NSString *name;
//    "province": "11",
@property (nonatomic, copy) NSString *province;
//    "city": "5",
@property (nonatomic, copy) NSString *city;
//    "location": "北京 朝阳区",
@property (nonatomic, copy) NSString *location;
//    "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
@property (nonatomic, copy) NSString *desc;
//    "url": "http://blog.sina.com.cn/zaku",
@property (nonatomic, copy) NSString *url;
//    "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
@property (nonatomic, copy) NSString *profile_image_url;
//    "domain": "zaku",
@property (nonatomic, copy) NSString *domain;
//    "gender": "m",
@property (nonatomic, copy) NSString *gender;
//    "followers_count": 1204,
@property (nonatomic, copy) NSString *followers_count;
//    "friends_count": 447,
@property (nonatomic, copy) NSString *friends_count;
//    "statuses_count": 2908,
@property (nonatomic, copy) NSString *statuses_count;
//    "favourites_count": 0,
@property (nonatomic, copy) NSString *favourites_count;
//    "created_at": "Fri Aug 28 00:00:00 +0800 2009",
@property (nonatomic, copy) NSString *created_at;
//    "following": false,
@property (nonatomic, copy) NSString *following;
//    "allow_all_act_msg": false,
@property (nonatomic, copy) NSString *allow_all_act_msg;
//    "remark": "",
@property (nonatomic, copy) NSString *remark;
//    "geo_enabled": true,
@property (nonatomic, copy) NSString *geo_enabled;
//    "verified": false,
@property (nonatomic, copy) NSString *verified;
//    "allow_all_comment": true,
@property (nonatomic, copy) NSString *allow_all_comment;
//    "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
@property (nonatomic, copy) NSString *avatar_large;
//    "verified_reason": "",
@property (nonatomic, copy) NSString *verified_reason;
//    "follow_me": false,
@property (nonatomic, copy) NSString *follow_me;
//    "online_status": 0,
@property (nonatomic, copy) NSString *online_status;
//    "bi_followers_count": 215
@property (nonatomic, copy) NSString *bi_followers_count;
/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 认证类型 */
@property (nonatomic, assign) MPUserVerifiedType verified_type;

@property (nonatomic, assign, getter=isVip) BOOL vip;
@end
