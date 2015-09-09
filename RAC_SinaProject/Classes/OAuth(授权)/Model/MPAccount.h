//
//  MPAccount.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPAccount : NSObject<NSCoding>

//"access_token" = "2.00bWzrkFstPpUC35fbddb9fbdkVQaD";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 5273243505;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy)NSString *uid;
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy)NSString *access_token;
/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy)NSNumber *expires_in;

@property (nonatomic, strong)NSDate *created_date;

@property (nonatomic, copy)NSString *name;

+ (MPAccount *)accountWithDictionary:(NSDictionary *)dictionary;

@end
