//
//  MPEmotion.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/17.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotion.h"

@interface MPEmotion () <NSCoding>

@end

@implementation MPEmotion

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}

@end
