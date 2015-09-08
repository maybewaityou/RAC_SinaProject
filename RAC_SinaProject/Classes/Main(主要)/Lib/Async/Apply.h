//
//  Apply.h
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^block)(size_t size);

@interface Apply : NSObject

+ (void)userInteractive:(int)iterations block:(block)block;

+ (void)userInitiated:(int)iterations block:(block)block;

+ (void)utility:(int)iterations block:(block)block;

+ (void)background:(int)iterations block:(block)block;

+ (void)customQueue:(dispatch_queue_t)queue iterations:(int)iterations block:(block)block;

@end
