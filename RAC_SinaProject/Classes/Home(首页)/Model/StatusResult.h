//
//  StatusResult.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusResult : NSObject

@property (nonatomic, copy) NSMutableArray *statuses;
//"previous_cursor": 0,
@property (nonatomic, copy) NSString *previous_cursor;
//"next_cursor": 11488013766,
@property (nonatomic, copy) NSString *next_cursor;
//"total_number": 81655
@property (nonatomic, copy) NSString *total_number;

@end
