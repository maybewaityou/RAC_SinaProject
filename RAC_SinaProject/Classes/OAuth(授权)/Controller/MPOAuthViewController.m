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
    
}
@end
