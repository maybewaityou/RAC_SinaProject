//
//  MPStatusTool.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/10/2.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPStatusTool.h"
#import "Status.h"
#import "FMDB.h"
#import "Constant.h"
#import "MPNMacros.h"

@implementation MPStatusTool

static FMDatabase *_db;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _db = [[FMDatabase alloc] initWithPath:path];
    [_db open];
    
    [_db executeUpdate:MPCreateTableSQL];
}

+ (NSArray *)statusWithParams:(NSDictionary *)params;
{
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = MPQueryNewStatusSQL;
    }else if(params[@"max_id"]){
        sql = MPQueryMoreStatUsSQL;
    }else{
        sql = MPQueryStatusSQL;
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [statuses addObject:status];
    }
    
    return statuses;
}

+ (void)saveStatuses:(NSArray *)statuses
{
    for (NSDictionary *status in statuses) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@)", statusData, status[@"idstr"]];
    }
}

@end
