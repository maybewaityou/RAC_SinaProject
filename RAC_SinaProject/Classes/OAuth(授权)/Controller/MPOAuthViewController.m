//
//  MPOAuthViewController.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPOAuthViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "Constant.h"
#import "AFNetworking.h"
#import "MPAccount.h"
#import "MPAccountTool.h"
#import "UIWindow+Extension.h"

@interface MPOAuthViewController ()<UIWebViewDelegate>

@end

@implementation MPOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    @weakify(self);
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(20);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    NSURL *url = [NSURL URLWithString:OAUTH_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"===>>> webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"===>>> webViewDidFinishLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromeIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromeIndex];

        [self fetchAccessToken:code];
    }
    return YES;
}

- (void)fetchAccessToken:(NSString *)code
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2287771596";
    params[@"client_secret"] = @"ace05cd07ee20f4704292c286c887d51";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^void(AFHTTPRequestOperation *operation, id responseObject) {
        MPAccount *account = [MPAccount accountWithDictionary:responseObject];
        [MPAccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootController];
    } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"===>>> %@",error.localizedDescription);
    }];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
