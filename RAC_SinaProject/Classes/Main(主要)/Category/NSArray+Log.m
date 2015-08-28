//
//  NSArray+Log.m
//  应用程序管理
//
//  Created by 刘凡 on 14/8/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    for (id obj in self) {
        [strM appendFormat:@"\t%@,\n", obj];
    }
    
    [strM appendString:@")\n"];
    
    return strM;
}

@end
