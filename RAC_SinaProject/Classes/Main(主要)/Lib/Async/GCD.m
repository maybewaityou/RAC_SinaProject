//
//  GCDQueue.m
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "GCD.h"

@implementation GCD

#pragma mark - DSL for GCD queues

/* dispatch_get_queue() */
+ (dispatch_queue_t)mainQueue
{
    return dispatch_get_main_queue();
}

+ (dispatch_queue_t)userInteractiveQueue
{
    return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
}

+ (dispatch_queue_t)userInitiatedQueue
{
    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
}

+ (dispatch_queue_t)utilityQueue
{
    return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
}

+ (dispatch_queue_t)backgroundQueue
{
    return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
}

@end
