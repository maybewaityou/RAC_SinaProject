//
//  MPCodingMacros.h
//  RuntimeDemo
//
//  Created by ChunNan on 15/10/12.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#ifndef MPCodingMacros_h
#define MPCodingMacros_h

#import <objc/runtime.h>

#define MPCoding(className) \
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
    unsigned int count = 0; \
    Ivar *ivars = class_copyIvarList([className class], &count); \
    for (int i=0; i<count; i++) { \
        Ivar ivar = ivars[i]; \
        const char *name = ivar_getName(ivar); \
         \
        NSString *key = [NSString stringWithUTF8String:name]; \
        id value = [self valueForKey:key]; \
        [encoder encodeObject:value forKey:key]; \
    } \
} \
 \
- (instancetype)initWithCoder:(NSCoder *)decoder \
{ \
    if (self) { \
        unsigned int count = 0; \
        Ivar *ivars = class_copyIvarList([className class], &count); \
        for (int i=0; i<count; i++) { \
            Ivar ivar = ivars[i]; \
            const char *name = ivar_getName(ivar); \
             \
            NSString *key = [NSString stringWithUTF8String:name]; \
            id value = [decoder decodeObjectForKey:key]; \
            [self setValue:value forKey:key]; \
        } \
    } \
    return self; \
}

#endif /* MPCodingMacros_h */
