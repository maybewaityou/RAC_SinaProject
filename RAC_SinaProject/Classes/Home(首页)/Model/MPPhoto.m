//
//  MPPhoto.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/6.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPPhoto.h"

@implementation MPPhoto

- (NSString *)description
{
    return [NSString stringWithFormat:@"MPPhoto description:%@\n thumbnail_pic: %@\n",[super description], self.thumbnail_pic];
}
@end
