//
//  Apply.m
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "Apply.h"
#import "GCD.h"

@implementation Apply

// DSL for GCD dispatch_apply()
//
// Apply runs a block multiple times, before returning.
// If you want run the block asynchronously from the current thread,
// wrap it in an Async block,
// e.g. Async.main { Apply.background(3) { ... } }

+ (void)userInteractive:(int)iterations block:(block)block
{
    dispatch_apply(iterations, [GCD userInteractiveQueue], block);
}

+ (void)userInitiated:(int)iterations block:(block)block
{
    dispatch_apply(iterations, [GCD userInitiatedQueue], block);
}

+ (void)utility:(int)iterations block:(block)block
{
    dispatch_apply(iterations, [GCD utilityQueue], block);
}

+ (void)background:(int)iterations block:(block)block
{
    dispatch_apply(iterations, [GCD backgroundQueue], block);
}

+ (void)customQueue:(dispatch_queue_t)queue iterations:(int)iterations block:(block)block
{
    dispatch_apply(iterations, queue, block);
}


@end
