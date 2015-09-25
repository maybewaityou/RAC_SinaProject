//
//  Constant.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/25.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const MPAppKey = @"2287771596";
NSString *const MPAppSecret = @"ace05cd07ee20f4704292c286c887d51";
NSString *const MPRedirectURL = @"http://";

NSString *const POST = @"post";
NSString *const GET = @"get";

NSString *const BASE_URL = @"http://oostest.lan149.com:88/OOS/AppAPI.do";
NSString *const OAUTH_URL = @"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@";
NSString *const OAUTH_ACCESS_TOKEN_URL = @"https://api.weibo.com/oauth2/access_token";
NSString *const NEW_STATUS_URL = @"https://api.weibo.com/2/statuses/friends_timeline.json";
NSString *const USER_INFO_URL = @"https://api.weibo.com/2/users/show.json";
NSString *const SEND_STATUS_URL = @"https://api.weibo.com/2/statuses/update.json";
NSString *const SEND_STATUS_WITH_IMAGE_URL = @"https://upload.api.weibo.com/2/statuses/upload.json";
NSString *const UN_READ_STATUS_URL = @"https://rm.api.weibo.com/2/remind/unread_count.json";
const NSTimeInterval UN_READ_STATUS_TIMEINTERVAL = 60;

NSString *const MPEmotionDidSelectNotification = @"MPEmotionDidSelectNotification";
NSString *const MPSelectEmotionKey = @"MPSelectEmotionKey";
NSString *const MPEmotionDeleteNotification = @"MPEmotionDeleteNotification";

