//
//  SJCommonWebViewController.h
//  SJWebViewController
//
//  Created by SPIREJ on 16/1/19.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJCommonWebViewController : UIViewController

@property(nonatomic, assign)BOOL autoFit;
@property(nonatomic, assign)BOOL isHtml;

@property(nonatomic, retain)UIWebView *webView;
@property(nonatomic, copy)NSString *urlStr;
@property(nonatomic, copy)NSString *titleStr;

- (id)initWithURL:(NSString *)url title:(NSString *)title autoFit:(BOOL)isAutoFit;
- (id)initWithHtml:(NSString *)html title:(NSString *)title autoFit:(BOOL)isAutoFit;

@end
