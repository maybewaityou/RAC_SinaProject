//
//  Async.h
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Apply.h"

@interface Async : NSObject

/* dispatch_async() */
+ (Async *)main:(dispatch_block_t)block;

+ (Async *)userInteractive:(dispatch_block_t)block;

+ (Async *)userInitiated:(dispatch_block_t)block;

+ (Async *)utility:(dispatch_block_t)block;

+ (Async *)background:(dispatch_block_t)block;

+ (Async *)customQueue:()queue block:(dispatch_block_t)block;

/* dispatch_after() */
+ (Async *)mainAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

+ (Async *)userInteractiveAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

+ (Async *)userInitiatedAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

+ (Async *)utilityAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

+ (Async *)backgroundAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

+ (Async *)customQueue:(dispatch_queue_t)queue after:(NSTimeInterval)after block:(dispatch_block_t)block;

#pragma mark - Async – Regualar methods matching static ones
/* dispatch_async() */
- (Async *)main:(dispatch_block_t)chainingBlock;

- (Async *)userInteractive:(dispatch_block_t)chainingBlock;

- (Async *)userInitiated:(dispatch_block_t)chainingBlock;

- (Async *)utility:(dispatch_block_t)chainingBlock;

- (Async *)background:(dispatch_block_t)chainingBlock;

- (Async *)customQueue:(dispatch_queue_t)queue chainingBlock:(dispatch_block_t)chainingBlock;

/* dispatch_after() */
- (Async *)mainAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

- (Async *)userInteractiveAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

- (Async *)userInitiatedAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

- (Async *)utilityAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

- (Async *)backgroundAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

- (Async *)customQueue:(dispatch_queue_t)queue after:(NSTimeInterval)after block:(dispatch_block_t)block;

/* cancel */
- (void)cancel;

/* wait */
/// If optional parameter forSeconds is not provided, use DISPATCH_TIME_FOREVER
- (void)wait:(NSTimeInterval)seconds;
- (void)wait;





@end
