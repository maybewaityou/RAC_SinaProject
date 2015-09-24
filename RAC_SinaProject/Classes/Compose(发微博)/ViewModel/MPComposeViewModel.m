//
//  MPComposeViewModel.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposeViewModel.h"
#import "MPAccountTool.h"
#import "MPAccount.h"
#import "MPComposeService.h"
#import "ModelNetwork.h"
#import "ReactiveCocoa.h"
#import "Constant.h"
#import "AFHTTPRequestOperationManager.h"

@interface MPComposeViewModel ()

@property (nonatomic, strong)MPComposeService *service;

@end

@implementation MPComposeViewModel

- (instancetype)initWithNavController:(UINavigationController *)controller
{
    self = [super init];
    if (self) {
        _service = [[MPComposeService alloc] initWithNavController:controller];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    MPAccount *account = [MPAccountTool account];
    NSString *name = account.name;
    NSString *prefix = @"发微博";
    if (name) {
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        _attrStr = attrStr;
    }else{
        _name = prefix;
    }
}

- (void)sendStatus
{
    MPAccount *account = [MPAccountTool account];
    @weakify(self);
    [[[[self.service getNetworkService] signalWithType:@"post" url:SEND_STATUS_URL
                                           parameter:@{
                                                       @"access_token" : account.access_token,
                                                       @"status" : self.textToSend
                                                       }]
    doNext:^(id x) {
        @strongify(self);
        self.isSendSuccess = YES;
    }] subscribeError:^(NSError *error) {
        @strongify(self);
        self.isSendSuccess = NO;
    }];
}

- (void)sendStatusWithPhotos:(NSArray *)photos
{
    MPAccount *account = [MPAccountTool account];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textToSend;

    @weakify(self);
    [mgr POST:SEND_STATUS_WITH_IMAGE_URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        @strongify(self);
        self.isSendSuccess = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @strongify(self);
        self.isSendSuccess = NO;
    }];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
