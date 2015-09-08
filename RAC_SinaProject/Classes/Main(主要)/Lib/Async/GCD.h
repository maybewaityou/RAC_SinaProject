//
//  GCDQueue.h
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject

+ (dispatch_queue_t)mainQueue;

+ (dispatch_queue_t)userInteractiveQueue;

+ (dispatch_queue_t)userInitiatedQueue;

+ (dispatch_queue_t)utilityQueue;

+ (dispatch_queue_t)backgroundQueue;

@end
