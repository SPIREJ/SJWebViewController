//
//  SJFirstWebViewVC.m
//  SJWebViewController
//
//  Created by SPIREJ on 16/1/18.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJFirstWebViewVC.h"
#define kNetWorkUrl                  @"http://www.baidu.com"
@interface SJFirstWebViewVC ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation SJFirstWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"百度一下";

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [self requestHtml];
}

- (void)requestHtml{
    NSString *urlStr = [NSString stringWithFormat:kNetWorkUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSString *urlString = request.URL.absoluteString;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
