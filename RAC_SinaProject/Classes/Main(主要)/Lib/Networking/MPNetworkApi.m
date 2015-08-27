//
//  MPNetworkApi.m
//  JCookDemo
//
//  Created by ChunNan on 15/6/2.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPNetworkApi.h"
#import "Constant.h"
//#import "CocoaLumberjack.h"
#import "ReactiveCocoa.h"
#import "MaterialProgress.h"

@interface MPNetworkApi ()

@end

@implementation MPNetworkApi

#pragma mark - 1.检测网络状态
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", status);
    }];
}

#pragma mark - 2.JSON方式获取数据
+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dict = @{@"format": @"json"};
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}

#pragma mark - 3.xml方式获取数据
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 返回的数据格式是XML
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *dict = @{@"format": @"xml"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}

#pragma mark - 4.post提交json数据
+ (void)postJSONWithmethod:(NSString *)method parameters:(id)parameters success:(void (^)(id result))success
{
    [MPNetworkApi postJSONWithUrl:BASE_URL method:method parameters:parameters success:success fail:nil];
}

+ (void)postJSONWithmethod:(NSString *)method parameters:(id)parameters success:(void (^)(id result))success fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))fail
{
    [MPNetworkApi postJSONWithUrl:BASE_URL method:method parameters:parameters success:success fail:fail];
}

+ (void)postJSONWithUrl:(NSString *)urlStr method:(NSString *)method parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))fail
{
    [[MaterialProgress sharedMaterialProgress] show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置请求超时时间（默认60s）
    manager.requestSerializer.timeoutInterval = 30.f;
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{
                          @"header": [MPNetworkApi requestHeaders],
                          @"request":[MPNetworkApi requestBodyWithMethod:method parameters:parameters]
                          };
    
//    DDLogInfo(@"= params =======>>> %@",params);
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[MaterialProgress sharedMaterialProgress] dismiss];
        
        NSDictionary *responseDic = responseObject[@"response"];
        NSDictionary *resultDic = responseDic[@"result"];

//        DDLogInfo(@"= method =======>>> %@",responseDic[@"method"]);
//        DDLogInfo(@"= result =======>>> %@",resultDic);
//        DDLogInfo(@"==========================================================================");
        if (success) {
            success(resultDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DDLogError(@"= error =======>>> %@",error.localizedDescription);
        [[MaterialProgress sharedMaterialProgress] dismiss];
        if (fail) {
            fail(operation, error);
        }
    }];
    
}

#pragma mark - 5.下载文件
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        //        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        if (success) {
            success(fileURL);
        }
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        if (fail) {
            fail();
        }
    }];
    
    [task resume];
}

#pragma mark - 6.文件上传－自定义上传文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //@"http://localhost/demo/upload.php"
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        // 要上传保存在服务器中的名称
        // 使用时间来作为文件名 2014-04-30 14:20:57.png
        // 让不同的用户信息,保存在不同目录中
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        // 设置日期格式
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        //        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        
        //@"image/png"
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:fileTye error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail();
        }  
    }];  
}

#pragma mark - 7.文件上传－随机生成文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //
        //        NSLog(@"完成 %@", result);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }  
    }];  
}

#pragma mark - Private
+ (NSDictionary *)requestHeaders
{
    return @{
             @"agent": @"iPhone",
             @"version": @"1.0.0",
             @"device": [[UIDevice currentDevice] model],
             @"platform": [NSString stringWithFormat:@"%@,%@",[UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion],
             @"page": @"",
             @"local": @"zh_CN",
             @"ext": @"",
             @"plugins": @""
             };
}

#pragma mark - Public（上传参数）
+ (NSDictionary *)requestBodyWithMethod:(NSString *)method parameters:(NSDictionary *)parameters
{
    return @{
             @"method": method,
             @"id": [NSString stringWithFormat:@"%ld", random()],
             @"params": parameters
             };
}

#pragma mark - -支持RAC访问网络
+ (RACSignal *)signalFromNetworkWithMethod:(NSString *)method arguments:(NSDictionary *)args
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [MPNetworkApi postJSONWithmethod:method parameters:args success:^(id responseObject) {
            if (responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject objectForKey:@"errorMessage"]) {
                        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:-1 userInfo:@{@"NSLocalizedDescriptionKey":responseObject[@"errorMessage"]}];
                        [subscriber sendError:error];
                        return;
                    }
                }
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
            // TODO 网络请求失败，统一处理
            [subscriber sendError: error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
