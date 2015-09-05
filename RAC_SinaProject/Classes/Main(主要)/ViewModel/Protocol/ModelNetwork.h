//
//  ModelProtocol.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/19.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

@class RACSignal;

@protocol ModelNetwork <NSObject>

- (RACSignal *)signalWithMethod:(NSString *)method parameter:(NSDictionary *)dic;

- (RACSignal *)signalWithType:(NSString *)type url:(NSString *)url parameter:(NSDictionary *)dic;

@end
