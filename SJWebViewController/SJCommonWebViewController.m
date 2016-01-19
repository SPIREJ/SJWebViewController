//
//  SJCommonWebViewController.m
//  SJWebViewController
//
//  Created by SPIREJ on 16/1/19.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJCommonWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight          [UIScreen mainScreen].bounds.size.height

@interface SJCommonWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
}


@end

@implementation SJCommonWebViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isHtml = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_progressView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    _webView.delegate = self;
    _webView.scalesPageToFit = _autoFit;
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor lightGrayColor];
    
    //创建进度条
    if (!_isHtml) {
        [self creatWebViewProgress];
    }
    //加载页面
    [self loadWebPage:_urlStr];
}

- (id)initWithURL:(NSString *)url title:(NSString *)title autoFit:(BOOL)isAutoFit{
    self = [super init];
    if (self) {
        _urlStr = url;
        _titleStr = title;
        _autoFit = isAutoFit;
        _isHtml = NO;
    }
    return self;
}

- (id)initWithHtml:(NSString *)html title:(NSString *)title autoFit:(BOOL)isAutoFit{
    if (self = [super init]) {
        _urlStr = html;
        _titleStr = title;
        _autoFit = isAutoFit;
        _isHtml = YES;
    }
    return self;
}

- (void)creatWebViewProgress{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _progressView.progressBarView.backgroundColor = [UIColor orangeColor];
    _progressView.progress = 0;
}

- (void)loadWebPage:(NSString *)urlStr{
    if (_isHtml) {
        [_webView loadHTMLString:urlStr baseURL:nil];
    }else{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:request];
    }
}

//界面标题
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *documentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([self isStringOk:documentTitle]) {
        self.navigationItem.title = documentTitle;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *documentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([self isStringOk:documentTitle]) {
        self.navigationItem.title = documentTitle;
    }
    return YES;
}

- (BOOL)isStringOk:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"null"]) {
        return NO;
    }
    if (str != nil && [str length] >0 && ![@"" isEqualToString:str]) {
        return YES;
    }else {
        return NO;
    }
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
