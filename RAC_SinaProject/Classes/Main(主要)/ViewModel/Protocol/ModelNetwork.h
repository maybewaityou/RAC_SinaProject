//
//  ModelProtocol.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/19.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "ReactiveCocoa.h"

@protocol ModelNetwork <NSObject>

- (RACSignal *)signalWithMethod:(NSString *)method parameter:(NSDictionary *)dic;

@end
