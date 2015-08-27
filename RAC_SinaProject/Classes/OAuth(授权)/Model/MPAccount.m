//
//  MPAccount.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPAccount.h"

@implementation MPAccount

+ (MPAccount *)accountWithDictionary:(NSDictionary *)dictionary
{
    MPAccount *account = [[MPAccount alloc] init];
    account.uid = dictionary[@"uid"];
    account.expires_in = dictionary[@"expires_in"];
    account.access_token = dictionary[@"access_token"];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
    }
    return self;
}

@end
