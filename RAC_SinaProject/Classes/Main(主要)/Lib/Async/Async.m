//
//  Async.m
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "Async.h"
#import "GCD.h"

@interface Async ()

@property (nonatomic, copy)dispatch_block_t block;

@end

@implementation Async

#pragma mark - Async
- (instancetype)initWithBlock:(dispatch_block_t)block
{
    self = [super init];
    if (self) {
        _block = block;
    }
    return self;
}

#pragma mark - Async – Static methods

/* dispatch_async() */
+ (Async *)async:(dispatch_block_t)block inQueue:(dispatch_queue_t)queue
{
    // Create a new block (Qos Class) from block to allow adding a notification to it later (see matching regular Async methods)
    // Create block with the "inherit" type
    dispatch_block_t tmpBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, block);
    // Add block to queue
    dispatch_async(queue, tmpBlock);
    // Wrap block in a struct since dispatch_block_t can't be extended
    return [[Async alloc] initWithBlock:tmpBlock];
}

+ (Async *)main:(dispatch_block_t)block
{
    return [Async async:block inQueue:[GCD mainQueue]];
}

+ (Async *)userInteractive:(dispatch_block_t)block
{
    return [Async async:block inQueue:[GCD userInteractiveQueue]];
}

+ (Async *)userInitiated:(dispatch_block_t)block
{
    return [Async async:block inQueue:[GCD userInitiatedQueue]];
}

+ (Async *)utility:(dispatch_block_t)block
{
    return [Async async:block inQueue:[GCD utilityQueue]];
}

+ (Async *)background:(dispatch_block_t)block
{
    return [Async async:block inQueue:[GCD backgroundQueue]];
}

+ (Async *)customQueue:()queue block:(dispatch_block_t)block
{
    return [Async async:block inQueue:queue];
}

/* dispatch_after() */
+ (Async *)after:(NSTimeInterval)seconds block:(dispatch_block_t)block inQueue:(dispatch_queue_t)queue
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    return [Async at:time block:block inQueue:queue];
}

+ (Async *)at:(dispatch_time_t)time block:(dispatch_block_t)block inQueue:(dispatch_queue_t)queue
{
    dispatch_block_t tmpBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, block);
    dispatch_after(time, queue, tmpBlock);
    return [[Async alloc] initWithBlock:tmpBlock];
}

+ (Async *)mainAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:[GCD mainQueue]];
}

+ (Async *)userInteractiveAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:[GCD userInteractiveQueue]];
}

+ (Async *)userInitiatedAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:[GCD userInitiatedQueue]];
}

+ (Async *)utilityAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:[GCD utilityQueue]];
}

+ (Async *)backgroundAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:[GCD backgroundQueue]];
}

+ (Async *)customQueue:(dispatch_queue_t)queue after:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [Async after:after block:block inQueue:queue];
}

#pragma mark - Async – Regualar methods matching static ones

/* dispatch_async() */
- (Async *)chain:(dispatch_block_t)chainingBlock runInQueue:(dispatch_queue_t)queue
{
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, chainingBlock);
    dispatch_block_notify(self.block, queue, block);
    return [[Async alloc] initWithBlock:block];
}

- (Async *)main:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:[GCD mainQueue]];
}

- (Async *)userInteractive:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:[GCD userInteractiveQueue]];
}

- (Async *)userInitiated:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:[GCD userInitiatedQueue]];
}

- (Async *)utility:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:[GCD utilityQueue]];
}

- (Async *)background:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:[GCD backgroundQueue]];
}

- (Async *)customQueue:(dispatch_queue_t)queue chainingBlock:(dispatch_block_t)chainingBlock
{
    return [self chain:chainingBlock runInQueue:queue];
}

/* dispatch_after() */
- (Async *)after:(NSTimeInterval)seconds chainingBlock:(dispatch_block_t)chainingBlock runInQueue:(dispatch_queue_t)queue
{
    // Create a new block (Qos Class) from block to allow adding a notification to it later (see Async)
    // Create block with the "inherit" type
    dispatch_block_t _chainingBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, chainingBlock);
    
    // Wrap block to be called when previous block is finished
    dispatch_block_t chainingWrapperBlock = ^{
        // Calculate time from now
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
        dispatch_after(time, queue, _chainingBlock);
    };
    // Create a new block (Qos Class) from block to allow adding a notification to it later (see Async)
    // Create block with the "inherit" type
    dispatch_block_t _chainingWrapperBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, chainingWrapperBlock);
    // Add block to queue *after* previous block is finished
    dispatch_block_notify(self.block, queue, _chainingWrapperBlock);
    // Wrap block in a struct since dispatch_block_t can't be extended
    return [[Async alloc] initWithBlock:_chainingBlock];
}

- (Async *)mainAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:[GCD mainQueue]];
}

- (Async *)userInteractiveAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:[GCD userInteractiveQueue]];
}

- (Async *)userInitiatedAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:[GCD userInitiatedQueue]];
}

- (Async *)utilityAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:[GCD utilityQueue]];
}

- (Async *)backgroundAfter:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:[GCD backgroundQueue]];
}

- (Async *)customQueue:(dispatch_queue_t)queue after:(NSTimeInterval)after block:(dispatch_block_t)block
{
    return [self after:after chainingBlock:block runInQueue:queue];
}

/* cancel */
- (void)cancel
{
    dispatch_block_cancel(self.block);
}

/* wait */

/// If optional parameter forSeconds is not provided, use DISPATCH_TIME_FOREVER
- (void)wait:(NSTimeInterval)seconds
{
    if (seconds != 0.0) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
        dispatch_block_wait(self.block, time);
    } else {
        dispatch_block_wait(self.block, DISPATCH_TIME_FOREVER);
    }
}

- (void)wait
{
    dispatch_block_wait(self.block, DISPATCH_TIME_FOREVER);
}

@end
