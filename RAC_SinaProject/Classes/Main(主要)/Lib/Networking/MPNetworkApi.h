//
//  MPNetworkApi.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/2.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ReactiveCocoa.h"

@interface MPNetworkApi : NSObject

// 检测网络状态
+ (void)netWorkStatus;

// JSON方式获取数据
+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;

// xml方式获取数据
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail;

// post提交json数据
+ (void)postJSONWithmethod:(NSString *)method parameters:(id)parameters success:(void (^)(id responseObject))success;
+ (void)postJSONWithmethod:(NSString *)method parameters:(id)parameters success:(void (^)(id result))success fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))fail;
+ (void)postJSONWithUrl:(NSString *)urlStr method:(NSString *)method parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))fail;

// 下载文件
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;

// 文件上传－自定义上传文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail;

// 文件上传－随机生成文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail;

// 支持RAC访问网络
+ (RACSignal *)signalFromNetworkWithMethod:(NSString *)method arguments:(NSDictionary *)args;

// 微博访问
+ (RACSignal *)signalFromNetworkWithType:(NSString *)type url:(NSString *)urlStr arguments:(NSDictionary *)args;

@end
