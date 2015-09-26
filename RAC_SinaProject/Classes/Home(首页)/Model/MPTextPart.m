//
//  MPTextPart.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/27.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPTextPart.h"

@implementation MPTextPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end
