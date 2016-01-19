//
//  ViewController.m
//  SJWebViewController
//
//  Created by SPIREJ on 16/1/18.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "ViewController.h"
#import "SJFirstWebViewVC.h"
#import "SJCommonWebViewController.h"
    
@interface ViewController ()
- (IBAction)firstWebView:(UIButton *)sender;
- (IBAction)secondWebView:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstWebView:(UIButton *)sender {
    SJFirstWebViewVC *firstWeb = [[SJFirstWebViewVC alloc] init];
    [self.navigationController pushViewController:firstWeb animated:YES];
}

- (IBAction)secondWebView:(UIButton *)sender {
    SJCommonWebViewController *webView = [[SJCommonWebViewController alloc] initWithURL:@"https://www.baidu.com" title:@"" autoFit:YES];
    [self.navigationController pushViewController:webView animated:YES];
}
@end
