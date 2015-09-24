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
#import "MPAccount.h"
#import "MPAccountTool.h"
#import "UIWindow+Extension.h"
#import "MaterialProgress.h"
#import "MPNetworkApi.h"

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
    
    NSString *oauthUrl = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", MPAppKey, MPRedirectURL];
    NSURL *url = [NSURL URLWithString:oauthUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[MaterialProgress sharedMaterialProgress] show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[MaterialProgress sharedMaterialProgress] dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[MaterialProgress sharedMaterialProgress] dismiss];
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
    [[MPNetworkApi signalFromNetworkWithType:@"" url:@"https://api.weibo.com/oauth2/access_token" arguments:@{
            @"client_id" : MPAppKey,
            @"client_secret" : MPAppSecret,
            @"grant_type" : @"authorization_code",
            @"redirect_uri" : MPRedirectURL,
            @"code" : code
        }
      ] subscribeNext:^(id responseObject) {
        MPAccount *account = [MPAccount accountWithDictionary:responseObject];
        [MPAccountTool saveAccount:account];

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootController];
    }];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
