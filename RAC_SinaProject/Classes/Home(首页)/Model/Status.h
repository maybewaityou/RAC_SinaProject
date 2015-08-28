//
//  Status.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Status : NSObject

//"created_at": "Tue May 31 17:46:55 +0800 2011",
@property (nonatomic, copy)NSString *created_at;
//"id": 11488058246,
@property (nonatomic, copy)NSString *idStr;
//"text": "求关注。",
@property (nonatomic, copy)NSString *text;
//"favorited": false,
@property (nonatomic, copy)NSString *favorited;
//"truncated": false,
@property (nonatomic, copy)NSString *truncated;
//"in_reply_to_status_id": "",
@property (nonatomic, copy)NSString *in_reply_to_status_id;
//"in_reply_to_user_id": "",
@property (nonatomic, copy)NSString *in_reply_to_user_id;
//"in_reply_to_screen_name": "",
@property (nonatomic, copy)NSString *in_reply_to_screen_name;
//"geo": null,
@property (nonatomic, copy)NSString *geo;
//"mid": "5612814510546515491",
@property (nonatomic, copy)NSString *mid;
//"reposts_count": 8,
@property (nonatomic, copy)NSString *reposts_count;
//"comments_count": 9,
@property (nonatomic, copy)NSString *comments_count;
//"annotations": [],
//"user": {
@property (nonatomic, strong)User *user;

@end
