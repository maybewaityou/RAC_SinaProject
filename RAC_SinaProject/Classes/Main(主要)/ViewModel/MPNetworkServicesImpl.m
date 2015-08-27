//
//  PersonalCenterReceivingAddressServicesImpl.m
//  JCookDemo
//
//  Created by ChunNan on 15/6/24.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNetworkServicesImpl.h"
#import "MPNetworkApi.h"

@implementation MPNetworkServicesImpl

- (RACSignal *)signalWithMethod:(NSString *)method parameter:(NSDictionary *)dic
{
    return [MPNetworkApi signalFromNetworkWithMethod:method arguments:dic];
}

@end
